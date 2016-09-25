pragma Singleton
import QtQuick 2.0
import OrmQuick 1.0

OrmMetaTable {
    table: "sec_Log"

    attributes:  [ 
        OrmMetaAttribute { property: 'idLog'; attribute: 'idSec_Log';  index: 0  },
        OrmMetaForeignKey{ property: 'usuario'; attribute: 'idUsuario'; foreignTable: "sec_Usuario"; index: 1  },
        OrmMetaForeignKey{ property: 'usuario'; attribute: 'idRol'; foreignTable: "sec_Usuario"; index: 2  },
        OrmMetaAttribute { property: 'fecha'; attribute: 'fecha';   },
        OrmMetaAttribute { property: 'msg'; attribute: 'msg';   }
    ]

    url: "../DB/Log.qml"
}
