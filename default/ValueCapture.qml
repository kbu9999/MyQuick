import QtQuick 2.0

Item {
    readonly property double value: parseFloat(prs.text)

    Keys.onPressed: {
        //console.log("capt key")
        if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
            prs.digit(event.text)
            event.accepted = true
            return;
        }

        switch(event.key) {
        case Qt.Key_Comma:
            prs.digit(".");
            event.accepted = true;
            break;
        }
    }

    Timer {
        id: timer
        interval: 1000
    }

    QtObject {
        id: prs
        property string text

        function digit(d) {
            if (!timer.running) prs.text = ""

            prs.text += d
            timer.start()
        }

        function action(f) {
            switch(f) {
            case "0": digit(f); break;
            case "Cl": prs.text = "0";  break;
            case ".": digit(f); break;
            }
        }
    }
}

