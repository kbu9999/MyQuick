import QtQuick 2.4
import QtQuick.Controls 1.1
import OrmQuick 1.0

import ".."
import "../Meta"
import "../DB"

Item {
    id: main

    property alias user: ld.usuario
    readonly property bool connected: user? true : false

    signal logged()
    signal loose();

    function logout() {
        addLog("fin de session")
        ld.usuario.deleteLater()
        ld.usuario = null
    }

    function addLog(msg) {
        if (!ld.usuario) return

        var vlog = MetaLog.create(this)
        if (!vlog) return

        vlog.usuario = ld.usuario
        vlog.fecha = new Date()
        vlog.msg = msg

        vlog.save()
        vlog.deleteLater()
    }


    property LoginStyle style: LoginStyle {
    }

    visible: user? false : true

    Loader {
        anchors.fill: parent
        sourceComponent: style.background
    }

    OrmLoader {
        id: ld
        table: MetaUsuario
        query: "SELECT * FROM sec_Usuario WHERE user = :user AND pass = md5(:pass)"

        property Usuario usuario

        onUsuarioChanged: {
            if (usuario) main.logged()
            else main.loose()
        }

        function login(user, pass) {
            addBindValue(":user", user)
            addBindValue(":pass", pass)
            fPass.clear()
            fUser.clear()
            fUser.focus = true
            var users = load();
            if (users.length <= 0) {
                error("no user or pass")
                return;
            }

            usuario = users[0]
            addLog("inicio de session")
        }

        onError: {
            console.log("login", error)
        }
    }

    Grid {
        id: grid
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        columns: 2

        verticalItemAlignment: Grid.AlignVCenter

        Loader { sourceComponent: style.userComponent }

        TextField {
            id: fUser
            placeholderText: "User"
            focus: true

            onEditingFinished: {
                fPass.focus = true
                fPass.selectAll()
            }

            style: main.style.textFieldStyle
        }

        Loader { sourceComponent: style.passComponent }

        TextField {
            id: fPass
            placeholderText: "Pass"
            echoMode: TextInput.Password

            Keys.onReturnPressed: ld.login(fUser.text, fPass.text)

            style: main.style.textFieldStyle
        }
    }
}
