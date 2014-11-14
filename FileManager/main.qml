import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import directory 1.0
import diskpartition 1.0

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
                        Layout.minimumWidth: parent.width * 0.8
                        Layout.maximumWidth: parent.width * 0.8
                    }

                    /* Change disk */
                    Button {
                        id: butt1
                        text: "Disk C:"
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

                                            console.log("Anim1 start")
                                        }
                                        else {
                                            xAnim2.start()
                                            console.log("Anim2 start")
                                        }

                                /* Set items visibility for layout 2 */
                                butt2.visible = true
                                butt3.visible = true
                                butt4.visible = true
                                butt5.visible = true
                                butt6.visible = true
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

                    /* First disk */
                    Button {
                        id: butt2
                        text: "Disk C:"
                        visible: false
                        Layout.maximumWidth: parent.width * 0.2
                        Layout.minimumWidth: parent.width * 0.2

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                butt1.text = "Disk C:"
                                myDir1.changeDir("C:")
                                addr1.text = "C://"
                                stack1.pop(true)
                            }
                        }

                    }

                    /* Second disk */
                    Button {
                        id: butt3
                        text: "Disk D:"
                        visible: false
                        Layout.maximumWidth: parent.width * 0.2
                        Layout.minimumWidth: parent.width * 0.2
                        //anchors.left: addr1.right

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                butt1.text = "Disk D:"
                                myDir1.changeDir("D:")
                                addr1.text = "D://"
                                stack1.pop(true)
                            }
                        }

                    }

                    /* Third disk */
                    Button {
                        id: butt4
                        text: "Disk E:"
                        visible: false
                        Layout.maximumWidth: parent.width * 0.2
                        Layout.minimumWidth: parent.width * 0.2

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                butt1.text = "Disk E:"
                                myDir1.changeDir("E:")
                                addr1.text = "E://"
                                stack1.pop(true)
                            }
                        }

                    }

                    /* Next disk */
                    Button {
                        id: butt5
                        text: "Next"
                        Layout.maximumWidth: parent.width * 0.2
                        Layout.minimumWidth: parent.width * 0.2
                        visible: false

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                stack1.pop(true)
                            }
                        }

                    }

                    /* Previous disk */
                    Button {
                        id: butt6
                        text: "Back"
                        Layout.maximumWidth: parent.width * 0.2
                        Layout.minimumWidth: parent.width * 0.2
                        visible: false

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                stack1.pop(true)
                            }
                        }

                    }
                }
            }

            /* Just a model (I dont know) */
            ListModel {
                id: listmodel
                ListElement { Name: "myDir1.test2()" ; Type: "virus"; Size: "2000 TBytes" }
            }

            /* Table of views (2 tabs) */
            TabView {
                /* First tab */
                Tab {
                    title: "Tab 1"
                    TableView {

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

                        model:myDir1.files
                        onActivated: {
                            myDir1.changeDir(myDir1.getDir() + "/" +model[currentRow].wholeName)
                            addr1.text = myDir1.getDir()
                        }
                    }
            }

            /* Second tab */
            Tab {
                title: "Tab 2"
                TableView {

                    TableViewColumn {
                        role: "name"
                        title: "Name"

                    }
                    TableViewColumn {
                        role: "type"
                        title: "Type"
                        width: 50
                    }
                    /*TableViewColumn {
                        role: "size"
                        title: "Size"
                        width: 100
                    }*/

                    model:myDir2.files
                    onActivated: {
                        myDir2.changeDir(myDir2.getDir() + "/" +model[currentRow].wholeName)
                        addr1.text = myDir1.getDir() + "/" +model[currentRow].wholeName
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
                //onActivated: console.log(model[currentRow].name)
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


