TEMPLATE = lib
TARGET = qml_barcode

QT += qml quick multimedia
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.kbu9999.Barcode

DISTFILES = qmldir \
    code39.js \
    Barcode.qml

include(../qmlmodule.pri)

qmldir.files = $$DISTFILES

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    INSTALLS += qmldir
}

HEADERS += \
    barcodereader.h

SOURCES += \
    barcodereader.cpp

LIBS += -lzbar
LIBS += -L /usr/lib/x86_64-linux-gnu/qt5 -lQtOpenCV
