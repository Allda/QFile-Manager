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

    /* */

    menuBar: MenuBar {
        Menu {
            title: "File"

            MenuItem {
                text: "New file"
                shortcut: "Ctrl+N"
                iconSource: "icons/new.png"
            }

            MenuItem {
                text: "Open file"
                shortcut: "Ctrl+O"
                iconSource: "icons/open.png"
            }

            MenuItem {
                text: "Save file"
                shortcut: "Ctrl+S"
                iconSource: "icons/save.png"
            }

            MenuSeparator { }

            MenuItem {
                text: "Exit"
                shortcut: "Ctrl+E"
            }
        }

        Menu {
            title: "Settings"

            MenuItem {
                text: "Colors"
            }
        }

        Menu {
            title: "Help"

            MenuItem {
                text: "About"
            }
        }
    }

    /*  */

    toolBar: ToolBar {
        id: tool
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

            TextField {
                Layout.fillWidth: true
                anchors.right: parent.right
            }
        }
    }

    /* */

    SplitView {
        id: split
        anchors.fill: parent

        SplitView {
            id: split2
            orientation: Qt.Vertical
            width: parent.width / 2

            TextField {
                placeholderText: "Zde bude adresa"
            }

            TableView {

                TableViewColumn {
                    title: "Name"
                }
                TableViewColumn {
                    title: "Type"
                    width: 50
                }
                TableViewColumn {
                    title: "Size"
                    width: 100
                }
            }
        }

        SplitView {
            id: split3
            orientation: Qt.Vertical

            TextField {
                placeholderText: "Zde bude adresa"
            }

            TableView {
                TableViewColumn {
                    title: "Name"
                }
                TableViewColumn {
                    title: "Type"
                    width: 50
                }
                TableViewColumn {
                    title: "Size"
                    width: 100
                }
            }
        }
    }

    /* */

    statusBar: StatusBar {
        RowLayout {
            width: parent.width
            Label {
                id: label
                text: "Zde muze byt cokoliv | ProgressBar muze ukazovat symbolicky cas do dokonceni operace"
                Layout.fillWidth: true
                elide: Text.ElideMiddle
            }
            ProgressBar {

            }
        }
    }
}
