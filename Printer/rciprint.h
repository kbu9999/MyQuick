#ifndef RCIPRINT_H
#define RCIPRINT_H

#include <QtCore>
#include <QPrinter>
#include <QQmlExtensionPlugin>

#include <QQuickItem>
#include <QQuickItemGrabResult>

class PrintPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:
    void registerTypes(const char *uri);
};



class AbstractPrinterArea : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QPrinter::PageSize pageSize READ pageSize WRITE setPageSize NOTIFY pageSizeChanged)
    Q_PROPERTY(int resolution READ resolution WRITE setResolution NOTIFY resolutionChanged)
    Q_PROPERTY(QSize pageSizeMM READ pageSizeMM WRITE setPageSizeMM NOTIFY pageSizeMMChanged)
    Q_PROPERTY(QSize pixelSize READ pixelSize NOTIFY pixelSizeChanged)
public:
    explicit AbstractPrinterArea(QQuickItem *parent = NULL);

    QPrinter::PageSize pageSize() const;
    void setPageSize(QPrinter::PageSize value);

    int resolution() const;
    void setResolution(int value);

    QSize pixelSize() const;
    void setPixelSize(QSize value);

    QSize pageSizeMM() const;
    void setPageSizeMM(QSize value);

    Q_INVOKABLE void clear();
    Q_INVOKABLE void addPage(QQuickItemGrabResult *result);
    Q_INVOKABLE void print();

signals:
    void pageSizeMMChanged(QSize value);
    void pixelSizeChanged(QSize value);
    void pageSizeChanged(QPrinter::PageSize value);
    void resolutionChanged(int value);

private:
    QSize m_pixelsize;
    QSize m_pagesizemm;
    QPrinter m_printer;
    QList<QImage> m_list;
};

#endif // RCIPRINT_H
