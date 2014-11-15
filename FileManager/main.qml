import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import directory 1.0
import diskpartition 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

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

    /* Main window */

    SplitView {
        id: split
        anchors.fill: parent

        /* Left window */
        SplitView {
            id: split2
            orientation: Qt.Vertical
            width: parent.width / 2
            Layout.minimumWidth: parent.width / 2
            Layout.maximumWidth: parent.width / 2

            /* Address line and button */
            StackView {
                id: stack1
                initialItem: item1
                Layout.minimumHeight: 25
                Layout.maximumHeight: 25

                /* Init layout */
                SplitView {
                    id: item1
                    anchors.fill: parent
                    Layout.minimumHeight: 25
                    Layout.maximumHeight: 25

                    /* Address line */
                    TextField {
                        id: addr1
                        placeholderText: "Address here"
                        Layout.minimumWidth: parent.width * 0.75
                        Layout.maximumWidth: parent.width * 0.75

                        onEditingFinished: {
                            var x = tview1.getTab(tview1.currentIndex).children[0].data[3]
                            x.changeDir(addr1.text)

                        }
                    }

                    /* Change disk */
                    Button {
                        id: butt1
                        text: "Change disk"
                        visible: true

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                /* If animations are complete */
                                if (xAnim1.running == false)
                                    if (xAnim2.running == false)
                                        if (stack1.x == 0) {
                                            xAnim1.start()
                                            //console.log("Anim1 start")
                                        }
                                        else {
                                            xAnim2.start()
                                            //console.log("Anim2 start")
                                        }

                                /* Set items visibility for layout 2 */

                                for (var i = 0; i < diskP1.getListLength(); i++) {
                                    rep1.itemAt(i).visible = true
                                }

                                /* Load layout with disk choose */
                                stack1.push(split5)
                            }
                        }
                    }

                    /* Animations of change layouts */
                    SequentialAnimation on x {
                        id: xAnim1
                        running: false
                        alwaysRunToEnd: true
                        NumberAnimation {
                            from: stack1.x;
                            to: -(stack1.width * 0.8);
                            duration: 2000;
                            easing.type: Easing.OutQuint


                        }
                    }

                    SequentialAnimation on x {
                        id: xAnim2
                        running: false
                        alwaysRunToEnd: true
                        NumberAnimation {
                            from: stack1.x;
                            to: 0;
                            duration: 2000;
                            easing.type: Easing.OutQuint
                        }
                    }
                }

                /* Layout (2) of choose disk */
                SplitView {
                    id: split5

                    Repeater {
                        id: rep1

                        model: diskP1.getListLength()

                        Button {
                            text: diskP1.diskList[index]
                            visible: false

                            Layout.maximumWidth: {
                                if ((split5.width / diskP1.getListLength()) > 50)
                                    split5.width / diskP1.getListLength()
                                else
                                    50
                            }
                            Layout.minimumWidth: {
                                if ((split5.width / diskP1.getListLength()) > 50)
                                    split5.width / diskP1.getListLength()
                                else
                                    50
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    /* Change disk */
                                    var x = tview1.getTab(tview1.currentIndex).children[0].data[3]
                                    x.changeDir(diskP1.diskList[index])
                                    /* Set disk path */
                                    addr1.text = diskP1.diskList[index]
                                    /* Return to origin state */
                                    stack1.pop(true)
                                }
                            }
                        }
                    }
                }
            }



            /* Table of views (2 tabs) */
            TabView {
                /* First tab */
                id: tview1
                Tab {
                    title: "Tab 1"
                    Component {
                        id: tab1
                        TableView {
                            selectionMode: SelectionMode.ExtendedSelection
                            sortIndicatorVisible: true

                            TableViewColumn {
                                role: "name"
                                title: "Name"

                            }
                            TableViewColumn {
                                role: "type"
                                title: "Type"
                                width: 50
                            }
                            TableViewColumn {
                                role: "size"
                                title: "Size"
                                width: 100
                            }

                            Directory {
                                 id: temp
                            }

                            model: {
                                temp.files
                            }
                            onActivated: {
                                temp.changeDir(temp.getDir() + "/" + model[currentRow].wholeName)
                                addr1.text = temp.getDir()
                            }
                       }
                   }

                    onActiveChanged: {
                        var x = tview1.getTab(tview1.currentIndex).children[0].data[3]
                        addr1.text = x.getDir()
                    }

                    onActiveFocusChanged: {
                        var x = tview1.getTab(tview1.currentIndex).children[0].data[3]
                        addr1.text = x.getDir()
                    }

               }

               /* Tab plus */
               Tab {
                  title: "+"

                  onActiveChanged: {
                      tview1.insertTab(tview1.count-1, "Tab " + tview1.count, tab1)
                      tview1.currentIndex = tview1.count-2

                      var x = tview1.getTab(tview1.currentIndex).children[0].data[3]
                      addr1.text = x.getDir()
                  }

                  onVisibleChanged: {
                      if (tview1.currentIndex == (tview1.count-1)) {
                          tview1.insertTab(tview1.count-1, "Tab " + tview1.count, tab1)
                          tview1.currentIndex = tview1.count-2

                          var x = tview1.getTab(tview1.currentIndex).children[0].data[3]
                          addr1.text = x.getDir()
                      }
                  }

               }
           }
    }

        /* Right window ... will be duplicate of left window */
        SplitView {
            id: split3
            orientation: Qt.Vertical
            resizing: false

            TextField {
                placeholderText: "Address here"
                Layout.minimumHeight: 20
                Layout.maximumHeight: 20
            }

            ListModel {
                id: listmodel2
                ListElement { Name: "ITU-project"; Type: "exe"; Size: "4224 Bytes" }
            }

            TableView {
                TableViewColumn {
                    role: "Name"
                    title: "Name"
                }
                TableViewColumn {
                    role: "Type"
                    title: "Type"
                    width: 50
                }
                TableViewColumn {
                    role: "Size"
                    title: "Size"
                    width: 100
                }

                model:listmodel2
                onActivated: console.log(diskP1.diskList[0])
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

    Directory{
        id: myDir1
    }
    Directory{
        id: myDir2
    }
    Directory{
        id: myDir3
    }

    DiskPartition{
        id: diskP1
    }



}


