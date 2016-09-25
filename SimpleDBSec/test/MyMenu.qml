import QtQuick 2.0
import QtQuick.Layouts 1.0

import ".."

MenuView {
    height: 50

    background: Rectangle {
        color: "#393939"
    }

    Item {
        Layout.fillWidth: true
    }

    Rectangle {
        width: 40
        height: 40
        color: showConfig? "blue" : "red"
        MouseArea {
            anchors.fill: parent
            onClicked: showConfig = !showConfig
        }
    }

    Text {
        id: text2
        color: "#ffffff"
        text: user? user.name : "Administrador"
        font.bold: true
        font.italic: true
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 15
    }
}
