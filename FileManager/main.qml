import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import directory 1.0
import diskpartition 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    width: 640
    minimumWidth: 640
    height: 480
    minimumHeight: 480
    title: "File Manager"

    /* */
    property variant clipboard: []
    property bool cutFlag: false
    property string lastFile: ""
    property real progressVal: 0.0
    property int lengthBut: 50
    property bool helpBut: false
    property string backgroundSource: "icons/save.png"

    Menu {
        title: "Edit"
        id: contextMenu

        MenuItem {
            id: cutOpt
            text: "Cut"
            shortcut: "Ctrl+X"
            onTriggered: cut()
        }

        MenuItem {
            id: copyOpt
            text: "Copy"
            shortcut: "Ctrl+C"
            onTriggered: {
                copy()
            }
        }

        MenuItem {
            id: pasteOpt
            text: "Paste"
            shortcut: "Ctrl+V"
            onTriggered: paste()
        }

        MenuItem {
            id: deleteOpt
            text: "Delete"
            //shortcut: "Ctrl+C"
            onTriggered: {
                showDeleteDialog()
            }
        }

        MenuItem {
            id: renameOpt
            enabled: false
            text: "Rename"
            //shortcut: "Ctrl+C"
            onTriggered: {
                lastFile = getCurrentRow()
                edtInput.text = lastFile
                edtInput.selectAll()
                renameDialog.visible
                renameDialog.open()
            }
        }

        MenuSeparator {
        }

        Menu {
            title: "Add.."

            MenuItem {
                id: addFolder
                text: "New folder"
                shortcut: "Ctrl+N"
                onTriggered: newFolder()
            }
            MenuItem {
                id: addFile
                text: "New file"
                shortcut: "Ctrl+Shift+N"
                onTriggered: newFile()
            }
        }
    }

    function copy() {
        cutFlag = false
        var x = getActivTab()
        addToClipboard(x)
    }

    function cut() {
        cutFlag = true
        var x = getActivTab()
        addToClipboard(x)
    }

    function paste() {
        if(getActivTab() === null)
            return
        var x = getActivTab().data[4]
        for (var i = 0; i < clipboard.length; i++) {
            if (cutFlag)
                x.moveToDir(clipboard[i])
            else
                x.copyToDir(clipboard[i])
            label.text = "Copy: " + clipboard[i]
            progressVal = (i + 1) / clipboard.length
            statusBar.update()


        }
        label.text = "Done"
    }

    function addToClipboard(tab) {
        var clip = new Array()
        if (tab === null)
            return
        tab.selection.forEach(function (rowIndex) {
            clip.push(tab.data[4].getDir(
                          ) + '/' + tab.model[rowIndex].wholeName)
        })
        clipboard = clip
    }

    function showDeleteDialog() {
        removeDialog.visible = true
        removeDialog.open()
    }

    function newFolder() {
        newFolderDialog.visible = true
        newFolderDialog.open()
    }

    function newFile() {
        newFileDialog.visible = true
        newFileDialog.open()
    }

    function del() {
        var x = getActivTab()
        if(x === null)
            return
        var len = getSelectionCount()
        ProgressBar.maximumValue = len
        var j = 1
        x.selection.forEach(function (rowIndex) {
            if (j == len)
                x.data[4].deleteFile(x.model[rowIndex].wholeName, true)
            else
                x.data[4].deleteFile(x.model[rowIndex].wholeName, false)

            j++
            ProgressBar.value = j
        })
    }

    function getActivTab() {
        if (tview1.focus) {
            var x = tview1.getTab(tview1.currentIndex).children[0]
        } /*else if(tview2.focus)
                            var x = tview2.getTab(tview2.currentIndex).children[0]*/
        else
            return null
        return x
    }

    function getSelectionCount() {
        var tab = getActivTab()
        if (tab === null)
            return 0
        return tab.selection.count
    }

    function cdUp() {
        if(getActivTab() === null)
            return
        var x = getActivTab().data[4]
        x.cdUp()
    }

    function getCurrentRow() {
        var x = getActivTab()
        if(x === null)
            return ""
        var a = ""
        x.selection.forEach(function (rowIndex) {
            a = x.model[rowIndex].wholeName
        })
        return a
    }


    MessageDialog {
        id: removeDialog

        title: "Delete files"
        text: "Do you realy want to remove these files."
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            del()
        }
        onNo: {

        }
    }

    Dialog {
        id: renameDialog
        title: "Rename file"
        height: 150
        width: 300
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        Column {
            anchors.fill: parent
            Text {
                text: "New name"
                height: 40
            }
            TextField {
                id: edtInput
                text: "Input text"
                width: parent.width * 0.75
                focus: true
            }
        }

        onButtonClicked: {
            if (clickedButton == StandardButton.Ok) {
                getActivTab().data[4].rename(lastFile, edtInput.text)
            }
        }
    }

    Dialog {
        id: newFolderDialog
        title: "New folder"
        height: 150
        width: 300
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        Column {
            anchors.fill: parent
            Text {
                text: "Name"
                height: 40
            }
            TextField {
                id: newFolderInput
                width: parent.width * 0.75
                focus: true
            }
        }

        onButtonClicked: {
            if (clickedButton == StandardButton.Ok) {
                getActivTab().data[4].newFolder(newFolderInput.text)
            }
            newFolderInput.text = ""
        }
    }

    Dialog {
        id: newFileDialog
        title: "New File"
        height: 150
        width: 300
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        Column {
            anchors.fill: parent
            Text {
                text: "Name"
                height: 40
            }
            TextField {
                id: newFileInput
                text: ""
                width: parent.width * 0.75
                focus: true
            }
        }

        onButtonClicked: {
            if (clickedButton == StandardButton.Ok) {
                getActivTab().data[4].newFile(newFileInput.text)
            }
            newFileInput.text = ""
        }
    }

    menuBar: MenuBar {
        Menu {
            title: "File"

            MenuItem {
                text: "New file"
                //shortcut: "Ctrl+N"
                //iconSource: "icons/new.png"
                iconSource: "icons/add26.png"
                onTriggered: newFile()
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

            MenuSeparator {
            }

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
                tooltip: text
                //iconSource: "icons/new.png"
                iconSource: "icons/add26.png"
                onClicked: newFile()
            }
            /*ToolButton {
                text: "Open file"
                iconSource: "icons/open.png"
            }*/
            ToolButton {
                text: "Save file"
                tooltip: text
                iconSource: "icons/save.png"
            }

            ToolButton {
                text: "Up"
                tooltip: text
                //iconSource: "icons/open.png"
                iconSource: "icons/upload58.png"
                onClicked: cdUp()
            }
            ToolButton {
                text: "Refresh"
                tooltip: text
                iconSource: "icons/refresh.png"
                onClicked: {
                    var x = getActivTab().data[4]
                    x.refresh()
                }
            }
            Label {
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
                            var x = tview1.getTab(
                                    tview1.currentIndex).children[0].data[4]
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
                                        } else {
                                            xAnim2.start()
                                            //console.log("Anim2 start")
                                        }

                                /* Set items visibility for layout 2 */
                                for (var i = 0; i < diskP1.getListLength(
                                         ); i++) {
                                    if (rep1.itemAt(i) !== null)
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
                            from: stack1.x
                            to: -(stack1.width * 0.8)
                            duration: 2000
                            easing.type: Easing.OutQuint
                        }
                    }

                    SequentialAnimation on x {
                        id: xAnim2
                        running: false
                        alwaysRunToEnd: true
                        NumberAnimation {
                            from: stack1.x
                            to: 0
                            duration: 2000
                            easing.type: Easing.OutQuint
                        }
                    }
                }

                /* Layout (2) of choose disk */
                SplitView {
                    id: split5

                    Repeater {
                        id: rep1

                        model: {
                            if ((split5.width / diskP1.getListLength(
                                     )) > lengthBut)
                                diskP1.getListLength()
                            else {
                                3
                            }
                        }

                        Button {
                            text: diskP1.diskList[index]
                            visible: false

                            Layout.maximumWidth: {
                                if ((split5.width / diskP1.getListLength(
                                         )) > lengthBut)
                                    split5.width / diskP1.getListLength()
                                else
                                    lengthBut
                            }
                            Layout.minimumWidth: {
                                if ((split5.width / diskP1.getListLength(
                                         )) > lengthBut)
                                    split5.width / diskP1.getListLength()
                                else
                                    lengthBut
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    /* Change disk */
                                    var x = tview1.getTab(
                                                tview1.currentIndex).children[0].data[4]
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
                //var clipboard = []
                Tab {
                    title: "Tab 1"
                    Component {
                        id: tab1
                        TableView {

                            onClicked: {
                                var pattern = /^.*\.(png|jpg|jpeg|JPG|PNG|JPEG)/;
                                if(pattern.test(getCurrentRow())){
                                    background.opacity = 0.3
                                    backgroundSource = "file://" + addr1.text + "/" +  getCurrentRow()
                                }
                                else{
                                    background.opacity = 0.0
                                }


                            }
                            selectionMode: SelectionMode.ExtendedSelection
                            sortIndicatorVisible: true
                            Image {
                                id: background
                                anchors.fill: parent
                                opacity: 0.0
                                anchors.topMargin: 25
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 20

                                source: backgroundSource
                            }
                            TableViewColumn{
                                role: "icon"

                                delegate:
                                     Image{
                                            source: styleData.value
                                            width: 15; height: 15
                                            fillMode: Image.PreserveAspectFit
                                     }
                                width: 20
                            }
                            TableViewColumn {
                                role: "name"
                                title: "Name"
                                width: (parent.width / 2)-20
                            }
                            TableViewColumn {
                                role: "type"
                                title: "Type"
                                width: parent.width / 4
                            }
                            TableViewColumn {
                                role: "size"
                                title: "Size"
                                width: parent.width / 4
                            }

                            Keys.onPressed: {
                                if (event.modifiers & Qt.ControlModifier) {
                                    // CTRL + ->
                                    if (event.key === Qt.Key_Right) {
                                        var x = tview1.getTab(
                                                    tview1.currentIndex).children[0]
                                        console.log('Copy')

                                        event.accepted = true
                                    }
                                }
                                if (event.modifiers & Qt.AltModifier) {
                                    // ALT + ->
                                    if (event.key === Qt.Key_Right) {
                                        var x = tview1.getTab(
                                                    tview1.currentIndex).children[0]
                                        console.log('Cut')

                                        event.accepted = true
                                    }
                                }
                                if (event.key == Qt.Key_Backspace) {
                                    cdUp()
                                }
                                if (event.key === Qt.Key_Delete) {
                                    showDeleteDialog()
                                }
                                if(event.key === Qt.Key_Down || event.key === Qt.Key_Up){
                                    var pattern = /^.*\.(png|jpg|jpeg|JPG|PNG|JPEG)/;
                                    if(pattern.test(getCurrentRow())){
                                        background.opacity = 0.3
                                        backgroundSource = "file://" + addr1.text + "/" +  getCurrentRow()
                                    }
                                    else{
                                        background.opacity = 0.0
                                    }
                                }
                            }

                            Directory {
                                id: temp
                            }

                            model: {
                                temp.files
                            }

                            onActivated: {
                                temp.changeDir(
                                            temp.getDir(
                                                ) + "/" + model[currentRow].wholeName)
                                addr1.text = temp.getDir()

                            }

                            MouseArea {
                                anchors.fill: parent
                                id: listMouseArea
                                acceptedButtons: Qt.RightButton
                                //propagateComposedEvents: true
                                onClicked:  {
                                    if (mouse.button == Qt.RightButton) {

                                        if (getSelectionCount() !== 1)
                                            renameOpt.enabled = false
                                        else
                                            renameOpt.enabled = true
                                        if (getSelectionCount() < 1) {
                                            cutOpt.enabled = false
                                            copyOpt.enabled = false
                                            deleteOpt.enabled = false
                                        } else {
                                            cutOpt.enabled = true
                                            copyOpt.enabled = true
                                            deleteOpt.enabled = true
                                        }
                                        contextMenu.popup()
                                    }
                                    //mouse.accepted = false
                                }
                                //onReleased: mouse.accepted = false
                                //onPressAndHold:  mouse.accepted = false
                            }


                        }
                    }

                    onActiveChanged: {
                        var x = tview1.getTab(
                                    tview1.currentIndex).children[0].data[4]
                        addr1.text = x.getDir()
                    }

                    onActiveFocusChanged: {
                        var x = tview1.getTab(
                                    tview1.currentIndex).children[0].data[4]
                        addr1.text = x.getDir()
                    }

                }

                /* Tab plus */
                Tab {
                    title: "+"
                    width: text.width + 24
                    height: 20

                    onActiveChanged: {
                        tview1.insertTab(tview1.count - 1,
                                         "Tab " + tview1.count, tab1)
                        tview1.currentIndex = tview1.count - 2

                        var x = tview1.getTab(
                                    tview1.currentIndex).children[0].data[4]
                        addr1.text = x.getDir()
                        console.log("Tab1");
                    }

                    onVisibleChanged: {
                        if (tview1.currentIndex == (tview1.count - 1)) {
                            tview1.insertTab(tview1.count - 1,
                                             "Tab " + tview1.count, tab1)
                            tview1.currentIndex = tview1.count - 2

                            var x = tview1.getTab(
                                        tview1.currentIndex).children[0].data[4]
                            addr1.text = x.getDir()
                            console.log("Tab2");
                        }
                    }
                }

                style: TabViewStyle {
                   property color frameColor: "lightsteelblue"
                   property color fillColor: "#91919B"
                   frameOverlap: 1

                   tab: Rectangle {
                       color: styleData.selected ? fillColor : frameColor
                       border.color: "#71717B"
                       implicitWidth: Math.max(text.width + 24, 80)
                       implicitHeight: 20
                       radius: 2
                       Text {
                           id: text
                           anchors.left: parent.left
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.leftMargin: 6
                           text: styleData.title
                           color: styleData.selected ? "white" : "black"
                       }

                       Rectangle {
                           id: neco
                           visible: {
                               if (tview1)
                                   if (tview1.count > 2)
                                       true
                                   else
                                       false
                           }
                           anchors.right: parent.right
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.rightMargin: 4
                           implicitWidth: 14
                           implicitHeight: 14
                           radius: width/2
                           color: "grey"
                           border.color: "black"
                           Text {text: "X" ; anchors.centerIn: parent ; color: "white"; font.pixelSize: 8;}
                           MouseArea {
                               hoverEnabled: true
                               anchors.fill: parent
                               onClicked: {
                                   console.log(tview1.currentIndex + "|" + tview1.count);

                                   var currentIndex = tview1.currentIndex
                                   tview1.currentIndex = 0;
                                   if (tview1.currentIndex >= 0) {
                                      var x = tview1.getTab(
                                              tview1.currentIndex).children[0].data[4]
                                      addr1.text = x.getDir()
                                   }
                                   tview1.removeTab(currentIndex)
                               }
                               onEntered: neco.color = "black";
                               onExited: neco.color = "grey";
                           }
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
                ListElement {
                    Name: "ITU-project"
                    Type: "exe"
                    Size: "4224 Bytes"
                }
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

                model: listmodel2
            }
        }
    }

    /* */
    statusBar: StatusBar {
        id:statusBar
        RowLayout {
            width: parent.width
            Label {
                id: label
                text: "Zde muze byt cokoliv | ProgressBar muze ukazovat symbolicky cas do dokonceni operace"
                Layout.fillWidth: true
                elide: Text.ElideMiddle
            }
            ProgressBar {
                id: progresBar
                value: progressVal
            }
        }
    }

    Directory {
        id: myDir1
    }
    Directory {
        id: myDir2
    }
    Directory {
        id: myDir3
    }

    DiskPartition {
        id: diskP1
    }
}
