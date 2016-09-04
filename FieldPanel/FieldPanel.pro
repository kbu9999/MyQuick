TEMPLATE = aux
TARGET = FieldPanel

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.kbu9999.FieldPanel

DISTFILES = qmldir \
    Field.qml \
    FieldComboBox.qml \
    FieldDate.qml \
    FieldSpinBox.qml \
    FieldTextEdit.qml \
    FieldTextFK.qml \
    Panel.qml

include(../qmlmodule.pri)


qmldir.files = $$DISTFILES

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    INSTALLS += qmldir
}
