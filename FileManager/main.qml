import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {
    visible: true
    width: 640
    minimumWidth: 640
    height: 480
    minimumHeight: 480
    title: "File Manager"


    toolBar: ToolBar {
        RowLayout {
            width: parent.width
            ToolButton {
                text: "New file"
                iconSource: "icons/new.png"
            }
            ToolButton {
                text: "Open file"
                iconSource: "icons/open.png"
            }
            ToolButton {
                text: "Save file"
                iconSource: "icons/save.png"
            }
            Slider {
                Layout.fillWidth: true
            }
            TextField {

            }
        }
    }


    SplitView {
        anchors.fill: parent
        TableView {
            TableViewColumn {
                title: "Name"
            }
            TableViewColumn {
                title: "Type"
            }
            TableViewColumn {
                title: "Size"
            }
        }

        TableView {
            TableViewColumn {
                title: "Name"
            }
            TableViewColumn {
                title: "Type"
            }
            TableViewColumn {
                title: "Size"
            }
        }
    }

    statusBar: StatusBar {
        Label {
            id: label
            text: "Zde muze byt cokoliv"
        }
        ProgressBar {

        }
    }
}
