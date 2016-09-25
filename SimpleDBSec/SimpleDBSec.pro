TEMPLATE = aux
TARGET = FieldPanel

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.kbu9999.SimpleDBSec

QMLFILES = BD/qmldir \
    BD/Plugin.qml \
    BD/Rol.qml \
    BD/RolDetalle.qml \
    BD/Usuario.qml \
    DB/Log.qml

QMLMETAFILES = Meta/qmldir \
    Meta/MetaPlugin.qml \
    Meta/MetaRol.qml \
    Meta/MetaRolDetalle.qml \
    Meta/MetaUsuario.qml \
    Meta/MetaLog.qml

QMLUIFILES = qmldir \
    ConfigPage.qml \
    ConfigStyle.qml \
    LoginStyle.qml \
    MenuView.qml \
    SecWindow.qml

PRFILES = private/PanelConfig.qml \
    private/PanelLogin.qml

DISTFILES = $$QMLFILES $$QMLMETAFILES \
    $$QMLUIFILES $$PRFILES

include(../qmlmodule.pri)


qmldir1.files = $$QMLUIFILES
qmldir2.files = $$QMLMETAFILES
qmldir3.files = $$QMLFILES
qmldir4.files = $$PRFILES

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir1.path = $$installPath
    qmldir2.path = $$installPath/Meta
    qmldir3.path = $$installPath/DB
    qmldir4.path = $$installPath/private
    INSTALLS += qmldir1 qmldir2 qmldir3 qmldir4
}
