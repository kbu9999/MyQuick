TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

# Default rules for deployment.
include(deployment.pri)

message($$QML_IMPORT_PATH)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /home/kbu9999/Documentos/workspace/MyQuick/build-MyQuick-Desktop-Debug
QML2_IMPORT_PATH = /home/kbu9999/Documentos/workspace/MyQuick/build-MyQuick-Desktop-Debug
