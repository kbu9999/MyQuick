import QtQuick 2.6
import com.kbu9999.FieldPanel 1.0


Rectangle {
    property alias mouseArea: mouseArea

    width: 360
    height: 360

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    Text {
        anchors.centerIn: parent
        text: "Hello World"
    }

    Panel {
        id: panel
    }
}
