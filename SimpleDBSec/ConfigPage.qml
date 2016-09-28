import QtQuick 2.4

QtObject {
    id: page
    property string title
    property Component config
    property list<QtObject> __data

    default property alias data: page.__data
}
