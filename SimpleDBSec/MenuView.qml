import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0

Item {
    id: bar
    implicitHeight: 80

    property list<Action> actions
    default property alias data: row.data

    property alias delegate: rep.delegate
    property alias background: back.sourceComponent

    function addAction(action) {
        var na = new Array(0)
        for (var i in actions) na.push(actions[i])
        na.push(action)
        actions = na
    }

    function clear() {
        actions = pr._actions
    }

    QtObject {
        id: pr
        property list<Action> _actions
    }

    Component.onCompleted: pr._actions = actions

    Loader {
        id: back
        anchors.fill: parent
    }

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.rightMargin: 10
        spacing: 5

        Repeater {
            id: rep
            model: actions
        }
    }
}

