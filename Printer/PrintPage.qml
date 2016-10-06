import QtQuick 2.0
import com.kbu9999.Printer 1.0

Rectangle {
    id: r1
    color: "white"

    property AbstractPrinterArea area
    property alias item: item
    default property alias data: item.data

    width:  area? area.pixelSize.width : 0
    height: area? area.pixelSize.height : 0

    Rectangle {
        id: r2
        anchors.fill: parent
        color: "transparent"
        border.color: "black"
        border.width: 1
        opacity: 0.5
    }

    Item {
        id: item
        anchors.fill: parent
    }
}
