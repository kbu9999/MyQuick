import QtQuick 2.2
import QtQuick.Window 2.1

import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0

import OrmQuick 1.0
import "private"

ApplicationWindow {
    id: main
    visible: true
    width: 800
    height: 600

    readonly property alias user: login.user
    property alias window: windowld.item
    property alias showConfig: config.visible

    function logout() {
        login.logout()
    }

    property MenuView menuView
    property Component mainComponent
    property alias loginStyle: login.style
    property list<ConfigPage> config


    onMenuViewChanged: {
        if (!menuView) return;

        menuView.parent = contentItem
    }

    Binding {
        when: menuView !== undefined
        target: menuView
        property: "width"
        value: width
    }

    property OrmDataBase db

    Component.onCompleted: {
        if (!db) return
        db.connect()

        config.visible = !db.connected
    }

    Item {
        id: mainc
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: menuView? menuView.bottom : parent.bottom

        Loader {
            id: windowld
            anchors.fill: parent

            readonly property alias user: login.user
            property alias menu: main.menuView
            property alias showConfig: config.visible
            property alias db: main.db

            function logout() {
                login.logout()
            }
        }

        PanelLogin {
            id: login
            anchors.fill: parent

            onLogged: {
                windowld.sourceComponent = main.mainComponent
            }

            onLoose: {
                windowld.sourceComponent = null
                if (menuView) menuView.clear()
            }
        }

        PanelConfig {
            id: config
            anchors.fill: parent
        }
    }
}
