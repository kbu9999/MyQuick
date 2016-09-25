#include "barcodereader.h"

#include <QPainter>

#include <opencv2/opencv.hpp>
#include "QtOpenCV.h"
#include <QCamera>

#include <zbar.h>

class BarcodeReader::Private {
public:
    bool enabled;
    zbar::ImageScanner scanner;
    BarcodeViewport* viewport;
    QObject* qmlcamera;
    QCamera *camera;
};

void BarcodePlugin::registerTypes(const char *uri)
{
    qmlRegisterType<BarcodeReader>(uri, 1, 0, "BarcodeReader");
    qmlRegisterType<BarcodeViewport>(uri, 1, 0, "BarcodeViewport");
}

BarcodeViewport::BarcodeViewport(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{
}

void BarcodeViewport::setFrame(const QImage &frame)
{
    if (frame.isNull()) return;

    m_frame = frame;
    update();
}

void BarcodeViewport::paint(QPainter *painter)
{
    painter->drawImage(boundingRect(), m_frame);
}


BarcodeReader::BarcodeReader() :
    QAbstractVideoSurface(),
    d(new Private)
{
    d->viewport = 0;
    d->qmlcamera = 0;
    d->camera = 0;
    d->enabled = true;
    d->scanner.set_config(zbar::ZBAR_NONE, zbar::ZBAR_CFG_ENABLE, 1);
}

BarcodeReader::~BarcodeReader()
{
    delete d;
}

bool BarcodeReader::enabled() const
{
    return d->enabled;
}

void BarcodeReader::setEnabled(bool value)
{
    if (d->enabled == value) return;
    d->enabled = value;
    emit enabledChanged(d->enabled);
}

QObject *BarcodeReader::camera() const
{
    return d->qmlcamera;
}

void BarcodeReader::setCamera(QObject *value)
{
    if (!value) return;
    QCamera *v = qvariant_cast<QCamera *>(value->property("mediaObject"));

    if (d->qmlcamera == v) return;
    d->qmlcamera = value;
    d->camera = v;
    emit cameraChanged(value);

    d->camera->setViewfinder(this);
}

BarcodeViewport *BarcodeReader::viewport() const
{
    return d->viewport;
}

void BarcodeReader::setViewport(BarcodeViewport *value)
{
    if (d->viewport == value) return;

    d->viewport = value;

    if (d->viewport)
        connect(d->viewport, &BarcodeViewport::destroyed, this, [=](){ setViewport(NULL); });

    emit viewportChanged(d->viewport);
}

bool BarcodeReader::present(const QVideoFrame &frame)
{
    QImage image;

    if (frame.isValid() && d->enabled)
    {
        QVideoFrame cloneFrame(frame);
        cloneFrame.map(QAbstractVideoBuffer::ReadOnly);
        QImage::Format imageFormat = QVideoFrame::imageFormatFromPixelFormat(cloneFrame.pixelFormat());
        image = QImage( cloneFrame.bits(),
                cloneFrame.width(),
                cloneFrame.height(),
                cloneFrame.bytesPerLine(),
                imageFormat);

        cloneFrame.unmap();

        cv::Mat tmp;
        cv::Mat img = QtOcv::image2Mat(image);
        cv::cvtColor(img, tmp, CV_BGR2GRAY);

        cv::adaptiveThreshold(tmp, tmp, 255, CV_ADAPTIVE_THRESH_MEAN_C, CV_THRESH_BINARY, 13, 6);
        cv::GaussianBlur(tmp, tmp, cv::Point(1.7, 1.7), 0);
        cv::threshold(tmp,tmp,0,255,cv::THRESH_BINARY + cv::THRESH_OTSU);

        uchar *raw = (uchar *)tmp.data;
        zbar::Image image(frame.width(), frame.height(), "Y800", raw, frame.width() * frame.height());
        if (d->scanner.scan(image) > 0) {
            for(zbar::Image::SymbolIterator symbol = image.symbol_begin(); symbol != image.symbol_end(); ++symbol)
                emit decoded(symbol->get_type_name().c_str(), symbol->get_data().c_str());
        } //*/
    }

    if (d->viewport)
        d->viewport->setFrame(image);

    return true;
}

QList<QVideoFrame::PixelFormat> BarcodeReader::supportedPixelFormats(QAbstractVideoBuffer::HandleType type) const
{
    Q_UNUSED(type)
    return QList<QVideoFrame::PixelFormat>() << QVideoFrame::Format_ARGB32;
}
