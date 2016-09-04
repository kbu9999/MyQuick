import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

import com.kbu9999.FieldPanel 1.0
import com.kbu9999.Barcode 1.0
import com.kbu9999.Columns 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MainForm {
        anchors.fill: parent
        mouseArea.onClicked: {
            Qt.quit();
        }

        Barcode {
            data: "22321"
        }

        TableView  {

            SpinBoxColumn  {
                title: "lalal"
            }
        }
    }
}
