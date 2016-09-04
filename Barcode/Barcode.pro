TEMPLATE = aux
TARGET = Barcode

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
