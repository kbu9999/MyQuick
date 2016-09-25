import QtQuick 2.4
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

QtObject {
    id: main

    property Component background
    property Component userComponent: Text {
        text: "Usuario"
    }
    property Component passComponent: Text {
        text: "Pass"
    }
    property Component textFieldStyle: TextFieldStyle {
    }
}
