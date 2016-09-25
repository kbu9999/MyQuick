import QtQuick 2.0
import OrmQuick 1.0

import "../Meta"

OrmObject {
    id: main
    metaTable: MetaLog
    
    property int idLog
    property Usuario usuario
    property date fecha
    property string msg
}
