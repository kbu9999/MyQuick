#ifndef IMAGEPROCESSOR_H
#define IMAGEPROCESSOR_H

#include <QtCore>
#include <QAbstractVideoSurface>
#include <QQmlExtensionPlugin>
#include <QQuickPaintedItem>


class BarcodePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:
    void registerTypes(const char *uri);
};

class BarcodeViewport;

class BarcodeReader : public QAbstractVideoSurface
{
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(QObject* camera READ camera WRITE setCamera NOTIFY cameraChanged)
    Q_PROPERTY(BarcodeViewport* viewport READ viewport WRITE setViewport NOTIFY viewportChanged)
public:
    BarcodeReader();
    virtual ~BarcodeReader();

    bool enabled() const;
    void setEnabled(bool value);

    QObject *camera() const;
    void setCamera(QObject* value);

    BarcodeViewport* viewport() const;
    void setViewport(BarcodeViewport* value);

    bool present(const QVideoFrame &frame);

    QList<QVideoFrame::PixelFormat>	supportedPixelFormats(
            QAbstractVideoBuffer::HandleType type = QAbstractVideoBuffer::NoHandle) const;
signals:
    void decoded(QString type, QString code);
    void enabledChanged(bool value);
    void cameraChanged(QObject* value);
    void viewportChanged(BarcodeViewport* value);

private:
    class Private;
    Private *d;
};

class BarcodeViewport : public QQuickPaintedItem
{
    Q_OBJECT
public:
    explicit BarcodeViewport(QQuickItem *parent = 0);

    void setFrame(const QImage &frame);

protected:
    void paint(QPainter *painter);

private:
    QImage m_frame;
};

#endif // IMAGEPROCESSOR_H
