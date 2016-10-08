TEMPLATE = lib
TARGET = qml_print

QT += qml quick printsupport
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.kbu9999.Print

unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += opencv
}

DISTFILES = qmldir \
    PrintArea.qml \
    PrintPage.qml

include(../qmlmodule.pri)

qmldir.files = $$DISTFILES

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

HEADERS += \
    rciprint.h

SOURCES += \
    rciprint.cpp
