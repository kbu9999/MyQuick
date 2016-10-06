import QtQuick 2.0

Item {
    id: stk
    readonly property alias current: pr.current

    QtObject {
        id: pr
        property Item current
    }

    onFocusChanged:  if (focus) pr.current.forceActiveFocus()

    function show(view) {
        if (pr.current === view) return;

        for(var i in children) {
            if (children[i] !== view) children[i].visible = false
        }
        view.visible = true
        pr.current = view;
    }
}

