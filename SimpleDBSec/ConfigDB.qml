import QtQuick 2.2
import QtQuick.Controls 1.1
import Qt.labs.settings 1.0
import com.kbu9999.SimpleDBSec 1.0

ConfigPage {
    id: page
    title: "Base de Datos"

    Settings {
        id: cfg
        category: "database"

        property string user
        property string pass
        property string host
        property string name

        onUserChanged: db.user = user
        onPassChanged: db.password = pass
        onHostChanged: db.host = host
        onNameChanged: db.database = name
    }

    config: Item {
        id: item1
        width: 300
        height: 400

        Grid {
            width: 300
            height: 300
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            columns: 2

            verticalItemAlignment: Grid.AlignVCenter

            Text {
                id: luser
                x: 121
                y: 110
                text: "Usuario"
                font.bold: true
            }

            TextField {
                text: cfg.user

                onEditingFinished: cfg.user = text

                KeyNavigation.tab: fpass
            }

            Text {
                id: lpass
                x: 137
                y: 146
                text: "Contraseña"
                font.bold: true
            }

            TextField {
                id: fpass
                text: cfg.pass
                echoMode: TextInput.Password

                onEditingFinished: cfg.pass = text

                KeyNavigation.tab: fname
            }

            Text {
                id: lname
                x: 128
                y: 192
                text: "Nombre"
                font.bold: true
            }

            TextField {
                id: fname
                text: cfg.name

                onEditingFinished: cfg.name = text

                KeyNavigation.tab: fhost
            }

            Text {
                id: lhost
                x: 121
                y: 251
                text: "Host"
                font.bold: true
            }

            TextField{
                id: fhost
                text: cfg.host

                onEditingFinished: cfg.host = text

                KeyNavigation.tab: bcon
            }

            Button {
                id: bcon
                text: "Conectar"

                onClicked: db.connect()
            }

        }

    }
}
