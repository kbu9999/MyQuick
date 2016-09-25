import QtQuick 2.4
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

QtObject {
    id: main

    property Component background: Rectangle {
        SystemPalette {
            id: myPalette;
            colorGroup: SystemPalette.Active
        }

        color: myPalette.window
    }

    property Component delegate: Text {
        text: title
        width: parent.width
        height: 50
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        MouseArea {
            anchors.fill: parent
            onClicked: view.select(index, config)
        }
    }

    property Component highlight: Rectangle {
        color: "skyblue"
    }
}
