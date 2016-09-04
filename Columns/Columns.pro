TEMPLATE = aux
TARGET = FieldPanel

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.kbu9999.Columns

DISTFILES = qmldir \
    ButtomColumn.qml \
    ComboBoxColumn.qml \
    EditingColumn.qml \
    FKColumn.qml \
    SpinBoxColumn.qml \
    TextFieldColumn.qml

include(../qmlmodule.pri)

qmldir.files = $$DISTFILES

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    INSTALLS += qmldir
}
