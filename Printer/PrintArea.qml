import QtQml 2.1
import QtQuick 2.2
import QtQuick.Controls 1.0

import com.kbu9999.Printer 1.0

AbstractPrinterArea {
    id: main

    resolution: 200
    pageSizeMM: Qt.size(70, 40)

    property double zoom: 0.8
    property list<PrintPage> _pages
    property alias model: rep.model
    property alias delegate: rep.delegate
    default property alias data: main._pages

    signal prindEnd()

    Rectangle {
        id: pr
        color: "#606060"
        anchors.fill: parent

        property int current: 0
        function next(result) {
            current++
            main.addPage(result)

            if (current >= _pages.length) {
                current = 0;
                main.print()
                prindEnd()
                return;
            }

            var page = _pages[current].item
            page.grabToImage(next, Qt.size(page.width, page.height))
            //console.log("next", _pages.length, current, page)
        }
    }

    ScrollView {
        anchors.fill: parent

        Column {
            id: pages
            spacing: 40

            transform: Scale {
                //origin { x: width / 2; } //y: height / 2 }
                yScale: main.zoom
                xScale: main.zoom
            }
        }
    }

    Instantiator {
        id: rep

        onObjectAdded: {
            object.area = main
            object.parent = pages
        }
    }

    on_PagesChanged: {
        var p = _pages[_pages.length - 1]
        if (p.area) return;

        p.area = main
        p.parent = pages
    }

    function startPrint() {
        clear()
        pr.current = 0;
        var page = _pages[0].item
        page.grabToImage(pr.next, Qt.size(page.width, page.height))
    }
}

