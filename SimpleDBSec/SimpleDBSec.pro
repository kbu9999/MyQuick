TEMPLATE = aux
TARGET = FieldPanel

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.kbu9999.SimpleDBSec

QMLFILES = qmldir \
    LoginManager.qml \
    Plugin.qml \
    Rol.qml \
    RolDetalle.qml \
    Usuario.qml

QMLMETAFILES = Meta/qmldir \
    Meta/MetaPlugin.qml \
    Meta/MetaRol.qml \
    Meta/MetaRolDetalle.qml \
    Meta/MetaUsuario.qml

DISTFILES = $$QMLFILES $$QMLMETAFILES


include(../qmlmodule.pri)


qmldir1.files = $$QMLFILES
qmldir2.files = $$QMLMETAFILES

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir1.path = $$installPath
    qmldir2.path = $$installPath/Meta
    INSTALLS += qmldir1 qmldir2
}