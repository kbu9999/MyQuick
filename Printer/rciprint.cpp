#include "rciprint.h"

#include <QtPrintSupport>

AbstractPrinterArea::AbstractPrinterArea(QQuickItem *parent) :
    QQuickItem(parent)
{
    setPageSize(QPrinter::A4);

    m_printer.setOutputFormat(QPrinter::PdfFormat);
    m_printer.setOutputFileName("/tmp/file.pdf");
}

QPagedPaintDevice::PageSize AbstractPrinterArea::pageSize() const
{
    return m_printer.pageSize();
}

void AbstractPrinterArea::setPageSize(QPagedPaintDevice::PageSize value)
{
    if (m_printer.pageSize() == value) return;

    m_printer.setPageSize(value);
    emit pageSizeChanged(value);

    m_pagesizemm = QSize(m_printer.widthMM(), m_printer.heightMM());
    emit pageSizeMMChanged(m_pagesizemm);

    setPixelSize(QSize(m_printer.width(), m_printer.height()));
}

int AbstractPrinterArea::resolution() const
{
    return m_printer.resolution();
}

void AbstractPrinterArea::setResolution(int value)
{
    if (m_printer.resolution() == value) return;

    m_printer.setResolution(value);
    emit resolutionChanged(value);

    m_pagesizemm = QSize(m_printer.widthMM(), m_printer.heightMM());
    emit pageSizeMMChanged(m_pagesizemm);

    setPixelSize(QSize(m_printer.width(), m_printer.height()));
}

QSize AbstractPrinterArea::pixelSize() const
{
    return m_pixelsize;
}

void AbstractPrinterArea::setPixelSize(QSize value)
{
    if (m_pixelsize == value) return;

    m_pixelsize = value;
    emit pixelSizeChanged(m_pixelsize);
}

QSize AbstractPrinterArea::pageSizeMM() const
{
    return m_pagesizemm;
}

void AbstractPrinterArea::setPageSizeMM(QSize value)
{
    if (m_pagesizemm == value) return;
    m_pagesizemm = value;

    m_printer.setPageSizeMM(value);
    setPixelSize(QSize(m_printer.width(), m_printer.height()));

    emit pageSizeMMChanged(m_pagesizemm);
}

void AbstractPrinterArea::clear()
{
    m_list.clear();
}

void AbstractPrinterArea::addPage(QQuickItemGrabResult *result)
{
    m_list.append(result->image());
}

void AbstractPrinterArea::print()
{
    QPainter p;
    p.begin(&m_printer);
    for(int i = 0; i < m_list.count() - 1; i++) {
        p.drawImage(0, 0, m_list.at(i));
        m_printer.newPage();
    }
    if (m_list.count() > 0)
        p.drawImage(0, 0, m_list.at(m_list.count() - 1));

    p.end();

    QDesktopServices::openUrl(QStringLiteral("/tmp/file.pdf"));
}


void PrintPlugin::registerTypes(const char *uri)
{
    qmlRegisterType<AbstractPrinterArea>(uri, 1, 0, "AbstractPrinterArea");
    qmlRegisterType(QUrl("PrintArea.qml"), uri, 1, 0, "PrintArea");
    qmlRegisterType(QUrl("PrintPage.qml"), uri, 1, 0, "PrintPage");
}
