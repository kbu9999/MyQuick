import QtQuick 2.4
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0

import ".."

Item {
    width: 400; height: 400

    property ConfigStyle style: ConfigStyle {
    }

    Loader {
        id: backld
        anchors.fill: parent
        sourceComponent: style.background
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5

        Rectangle {
            width: 200
            Layout.fillHeight: true
            color: "white"

            ListView {
                id: view
                anchors.fill: parent
                model: main.config
                currentIndex: -1

                function select(index, config) {
                    view.currentIndex = index
                    cfgLd.sourceComponent = config
                }

                delegate: style.delegate
                highlight: style.highlight
            }
        }

        Loader {
            id: cfgLd
            height: parent.height
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
