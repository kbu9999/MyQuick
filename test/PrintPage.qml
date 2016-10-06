import QtQuick 2.0

Rectangle {
    id: r1
    property PrintArea area
    color: "white"

    onAreaChanged: {
        if (!area) return;

        width = area.pagePixelWidth
        height = area.pagePixelHeight

        r2.anchors.margins = 2 * main.dpi / 25.4
    }

    Rectangle {
        id: r2
        anchors.fill: parent
        color: "transparent"
        border.color: "black"
        border.width: 1
        opacity: 0.5
    }
}
