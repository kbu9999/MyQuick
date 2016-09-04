TEMPLATE = aux
TARGET = default

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.kbu9999.default

DISTFILES = qmldir \
    FieldEdit.qml \
    FieldButton.qml \
    FieldCheck.qml \
    FieldSearch.qml \
    IconButton.qml \
    OpButton.qml \
    Search.qml \
    FieldCal.qml \

include(../qmlmodule.pri)


qmldir.files = $$DISTFILES

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    INSTALLS += qmldir
}
