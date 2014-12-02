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
    color: Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue,1)

    /* */
    property variant clipboard: []
    property bool cutFlag: false
    property string lastFile: ""
    property real progressVal: 0.0
    property int lengthBut: 50
    property bool helpBut: false
    property string backgroundSourceLeft: "icons/save.png"
    property string backgroundSourceRight: "icons/save.png"
    property real backgroundColorOfWholeAppRed: 0.9
    property real backgroundColorOfWholeAppGreen: 0.9
    property real backgroundColorOfWholeAppBlue: 0.9
    property real backgroundColorOfBothPanelsRed: 0.9
    property real backgroundColorOfBothPanelsGreen: 0.9
    property real backgroundColorOfBothPanelsBlue: 0.9
    property real backgroundTextColorOfWholeAppRed: 0.1
    property real backgroundTextColorOfWholeAppGreen: 0.1
    property real backgroundTextColorOfWholeAppBlue: 0.1
    property real backgroundTextColorOfBothPanelsRed: 0.1
    property real backgroundTextColorOfBothPanelsGreen: 0.1
    property real backgroundTextColorOfBothPanelsBlue: 0.1

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
            onTriggered: {
                paste()
                getLeftTab().data[4].refresh()
                getRightTab().data[4].refresh()
            }
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

    function copyCutFromTo(from, to, flag){
        addToClipboard(from)
        cutFlag = flag
        pasteToTab(to)
        getLeftTab().data[4].refresh()
        getRightTab().data[4].refresh()
    }

    function pasteToTab(tab) {

        var x = tab.data[4]
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

    function changeColor(){
        colorsDialog.visible = true
        colorsDialog.open()
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
        if (leftTabView.focus) {
            var x = leftTabView.getTab(leftTabView.currentIndex).children[0]
        } else if(rightTabView.focus)
            var x = rightTabView.getTab(rightTabView.currentIndex).children[0]
        else
            return null
        return x
    }

    function getLeftTab(){
        return leftTabView.getTab(leftTabView.currentIndex).children[0]
    }

    function getRightTab(){
        return rightTabView.getTab(rightTabView.currentIndex).children[0]
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

        onAccepted: getActivTab().data[4].rename(lastFile, edtInput.text)

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
                onFocusChanged: console.log("Focus changed " + focus)
            }
        }

        onVisibleChanged: newFolderInput.focus = true

        onVisibilityChanged: {
            if(visible === true){
                newFolderInput.text = ""
                newFolderInput.forceActiveFocus()
            }

        }


        onAccepted:{
            getActivTab().data[4].newFolder(newFolderInput.text)
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

        onVisibilityChanged: {
            if(visible === true)
            newFileInput.text = ""
        }

        onAccepted: getActivTab().data[4].newFile(newFileInput.text)

    }

    Dialog {
        id: colorsDialog
        title: "Change Color"
        height: 210
        width: 300
        standardButtons: StandardButton.Ok | StandardButton.Cancel
        TabView{
            anchors.fill: parent
            Tab{
                title: "Whole app"
                Rectangle{
                    anchors.fill: parent
                    anchors.topMargin: 10
                    Text {
                        id: wholeRedText
                        text: "Red"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: wholeRedSlider
                        anchors.left: wholeRedText.right
                        width: parent.width - 50
                        value: backgroundColorOfWholeAppRed
                        stepSize: 0.005
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundColorOfWholeAppRed = value
                    }
                    Text {
                        id: wholeGreenText
                        anchors.top: wholeRedText.bottom
                        text: "Green"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: wholeGreenSlider
                        anchors.left: wholeGreenText.right
                        anchors.top: wholeRedText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundColorOfWholeAppGreen
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundColorOfWholeAppGreen = value
                    }
                    Text {
                        id: wholeBlueText
                        anchors.top: wholeGreenText.bottom
                        text: "Blue"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: wholeBlueSlider
                        anchors.left: wholeBlueText.right
                        anchors.top: wholeGreenText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundColorOfWholeAppBlue
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundColorOfWholeAppBlue = value
                    }
                }
            }
            Tab{
                title: "Panels"
                Rectangle{
                    anchors.fill: parent
                    anchors.topMargin: 10
                    Text {
                        id: panelsRedText
                        text: "Red"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: panelsRedSlider
                        anchors.left: panelsRedText.right
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundColorOfBothPanelsRed
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundColorOfBothPanelsRed = value
                    }
                    Text {
                        id: panelsGreenText
                        anchors.top: panelsRedText.bottom
                        text: "Green"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: panelsGreenSlider
                        anchors.left: panelsGreenText.right
                        anchors.top: panelsRedText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundColorOfBothPanelsGreen
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundColorOfBothPanelsGreen = value
                    }
                    Text {
                        id: panelsBlueText
                        anchors.top: panelsGreenText.bottom
                        text: "Blue"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: panelsBlueSlider
                        anchors.left: panelsBlueText.right
                        anchors.top: panelsGreenText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundColorOfBothPanelsBlue
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundColorOfBothPanelsBlue = value
                    }
                }
            }
            Tab{
                title: "App text"
                Rectangle{
                    anchors.fill: parent
                    anchors.topMargin: 10
                    Text {
                        id: appTextColorRedText
                        text: "Red"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: appTextColorRedSlider
                        anchors.left: appTextColorRedText.right
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundTextColorOfWholeAppRed
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundTextColorOfWholeAppRed = value
                    }
                    Text {
                        id: appTextColorGreenText
                        anchors.top: appTextColorRedText.bottom
                        text: "Green"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: appTextColorGreenSlider
                        anchors.left: appTextColorGreenText.right
                        anchors.top: appTextColorRedText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundTextColorOfWholeAppGreen
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundTextColorOfWholeAppGreen = value
                    }
                    Text {
                        id: appTextColorBlueText
                        anchors.top: appTextColorGreenText.bottom
                        text: "Blue"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: appTextColorBlueSlider
                        anchors.left: appTextColorBlueText.right
                        anchors.top: appTextColorGreenText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundTextColorOfWholeAppBlue
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundTextColorOfWholeAppBlue = value
                    }
                }
            }
            Tab{
                title: "Panels"
                Rectangle{
                    anchors.fill: parent
                    anchors.topMargin: 10
                    Text {
                        id: panelsTextColorRedText
                        text: "Red"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: panelsTextColorRedSlider
                        anchors.left: panelsTextColorRedText.right
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundTextColorOfBothPanelsRed
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundTextColorOfBothPanelsRed = value
                    }
                    Text {
                        id: panelsTextColorGreenText
                        anchors.top: panelsTextColorRedText.bottom
                        text: "Green"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: panelsTextColorGreenSlider
                        anchors.left: panelsTextColorGreenText.right
                        anchors.top: panelsTextColorRedText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundTextColorOfBothPanelsGreen
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundTextColorOfBothPanelsGreen = value
                    }
                    Text {
                        id: panelsTextColorBlueText
                        anchors.top: panelsTextColorGreenText.bottom
                        text: "Blue"
                        height: 40
                        width: 50
                    }

                    Slider{
                        id: panelsTextColorBlueSlider
                        anchors.left: panelsTextColorBlueText.right
                        anchors.top: panelsTextColorGreenText.bottom
                        width: parent.width - 50
                        stepSize: 0.005
                        value: backgroundTextColorOfBothPanelsBlue
                        maximumValue: 1
                        minimumValue: 0
                        onValueChanged: backgroundTextColorOfBothPanelsBlue = value
                    }
                }
            }
        }
    }

 /*   menuBar: MenuBar {
        Menu {
            title: "File"

            MenuItem {
                text: "New file"
                //shortcut: "Ctrl+N"
                iconSource: "icons/new.png"
                //iconSource: "icons/add26.png"
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
                onTriggered: changeColor();
            }
        }

        Menu {
            title: "Help"

            MenuItem {
                text: "About"
            }
        }
    }
*/
    /*  */
    toolBar: ToolBar {
        id: tool
        style: ToolBarStyle{
            background: Rectangle{color: Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue,1)}
        }
        height: 75
        RowLayout {
            width: parent.width
            ToolButton {
                implicitWidth: 55
                implicitHeight: 70
                onClicked: newFile()

                anchors.rightMargin: 15
                style: ButtonStyle{
                    background: Rectangle{
                        width: 55
                        height: 65
                        color: control.hovered ? Qt.rgba(backgroundColorOfWholeAppRed + 0.05,backgroundColorOfWholeAppGreen + 0.05,backgroundColorOfWholeAppBlue + 0.05,1) : Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue,1)
                        Image{
                            width: 40
                            height: 40
                            y: 5
                            source: "icons/new_file.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                              text: "New file"
                              font.pointSize: 8
                              style: control.hovered ? Text.Raised : Text.Normal
                              styleColor: "#999"
                              color:Qt.rgba(backgroundTextColorOfWholeAppRed,backgroundTextColorOfWholeAppGreen,backgroundTextColorOfWholeAppBlue,1)
                              y: 51
                              //anchors.bottom: parent.bottom
                              anchors.horizontalCenter: parent.horizontalCenter
                         }
                    }
                }
            }
            /*ToolButton {
                text: "Open file"
                iconSource: "icons/open.png"
            }*/
            /*ToolButton {
                implicitWidth: 55
                implicitHeight: 70
                tooltip: "Save the file"
                anchors.rightMargin: 15
                style: ButtonStyle{
                    background: Rectangle{
                        width: 55
                        height: 65
                        color: control.hovered ? Qt.rgba(backgroundColorOfWholeAppRed + 0.05,backgroundColorOfWholeAppGreen + 0.05,backgroundColorOfWholeAppBlue + 0.05,1) : Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue,1)
                        Image{
                            width: 40
                            height: 40
                            y: 5
                            source: "icons/save.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                              text: "Save file"
                              font.pointSize: 8
                              style: control.hovered ? Text.Raised : Text.Normal
                              styleColor: "#999"
                              y: 51
                              color: Qt.rgba(backgroundTextColorOfWholeAppRed,backgroundTextColorOfWholeAppGreen,backgroundTextColorOfWholeAppBlue,1)
                              //anchors.bottom: parent.bottom
                              anchors.horizontalCenter: parent.horizontalCenter
                         }
                    }
                }
            }*/

            ToolButton {
                implicitWidth: 55
                implicitHeight: 70
                tooltip: "Go to folder above"
                //iconSource: "icons/upload58.png"
                onClicked: cdUp()
                anchors.rightMargin: 15
                style: ButtonStyle{
                    background: Rectangle{
                        width: 55
                        height: 65
                        color: control.hovered ? Qt.rgba(backgroundColorOfWholeAppRed + 0.05,backgroundColorOfWholeAppGreen + 0.05,backgroundColorOfWholeAppBlue + 0.05,1) : Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue,1)
                        Image{
                            width: 40
                            height: 40
                            y: 5
                            source: "icons/up.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                              text: "Up"
                              font.pointSize: 8
                              style: control.hovered ? Text.Raised : Text.Normal
                              styleColor: "#999"
                              y: 51
                              color: Qt.rgba(backgroundTextColorOfWholeAppRed,backgroundTextColorOfWholeAppGreen,backgroundTextColorOfWholeAppBlue,1)
                              //anchors.bottom: parent.bottom
                              anchors.horizontalCenter: parent.horizontalCenter
                         }
                    }
                }
            }
            ToolButton {
                implicitWidth: 55
                implicitHeight: 70
                tooltip: "Refresh panels"
                onClicked: {
                    if(getActivTab() === null)
                        return
                    var x = getActivTab().data[4]
                    x.refresh()

                }
                anchors.rightMargin: 15
                style: ButtonStyle{
                    background: Rectangle{
                        width: 55
                        height: 65
                        color: control.hovered ? Qt.rgba(backgroundColorOfWholeAppRed + 0.05,backgroundColorOfWholeAppGreen + 0.05,backgroundColorOfWholeAppBlue + 0.05,1) : Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue,1)
                        Image{
                            width: 40
                            height: 40
                            y: 5
                            source: "icons/refresh_icon.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                              text: "Refresh"
                              font.pointSize: 8
                              style: control.hovered ? Text.Raised : Text.Normal
                              styleColor: "#999"
                              color: Qt.rgba(backgroundTextColorOfWholeAppRed,backgroundTextColorOfWholeAppGreen,backgroundTextColorOfWholeAppBlue,1)
                              y: 51
                              //anchors.bottom: parent.bottom
                              anchors.horizontalCenter: parent.horizontalCenter
                         }
                    }
                }
            }
            ToolButton{
                implicitWidth: 55
                implicitHeight: 70
                tooltip: "Color settings"
                onClicked: changeColor();
                anchors.rightMargin: 15
                style: ButtonStyle{
                    background: Rectangle{
                        width: 55
                        height: 65
                        color: control.hovered ? Qt.rgba(backgroundColorOfWholeAppRed + 0.05,backgroundColorOfWholeAppGreen + 0.05,backgroundColorOfWholeAppBlue + 0.05,1) : Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue,1)
                        Image{
                            width: 40
                            height: 40
                            y: 5
                            source: "icons/color.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                              text: "Colors"
                              font.pointSize: 8
                              style: control.hovered ? Text.Raised : Text.Normal
                              styleColor: "#999"
                              y: 51
                              color: Qt.rgba(backgroundTextColorOfWholeAppRed,backgroundTextColorOfWholeAppGreen,backgroundTextColorOfWholeAppBlue,1)
                              //anchors.bottom: parent.bottom
                              anchors.horizontalCenter: parent.horizontalCenter
                         }
                    }
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
        id: mainWindow
        anchors.fill: parent


        /* Left window */
        SplitView {
            id: leftWindow
            orientation: Qt.Vertical
            width: parent.width / 2
            Layout.minimumWidth: parent.width / 2
            Layout.maximumWidth: parent.width / 2

            /* Address line and button */
            StackView {
                id: leftAddrLine
                initialItem: leftItem
                Layout.minimumHeight: 25
                Layout.maximumHeight: 25

                /* Init layout */
                SplitView {
                    id: leftItem
                    anchors.fill: parent
                    Layout.minimumHeight: 25
                    Layout.maximumHeight: 25

                    /* Address line */
                    TextField {
                        id: leftAddr
                        style: TextFieldStyle{ }
                        placeholderText: "Address here"
                        Layout.minimumWidth: parent.width * 0.75
                        Layout.maximumWidth: parent.width * 0.75

                        onEditingFinished: {
                            var x = leftTabView.getTab(
                                    leftTabView.currentIndex).children[0].data[4]
                                    x.changeDir(leftAddr.text)
                        }
                    }

                    /* Change disk */
                    Button {
                        id: leftButton
                        text: "Change disk"
                        visible: true

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                /* If animations are complete */
                                if (xAnim1.running == false)
                                    if (xAnim2.running == false)
                                        if (leftAddrLine.x == 0) {
                                            xAnim1.start()
                                            //console.log("Anim1 start")
                                        } else {
                                            xAnim2.start()
                                            //console.log("Anim2 start")
                                        }

                                /* Set items visibility for layout 2 */
                                for (var i = 0; i < diskP1.getListLength(
                                         ); i++) {
                                    if (leftRepeatButt.itemAt(i) !== null)
                                        leftRepeatButt.itemAt(i).visible = true
                                }

                                /* Load layout with disk choose */
                                leftAddrLine.push(leftChoose)
                            }
                        }
                    }

                    /* Animations of change layouts */
                    SequentialAnimation on x {
                        id: xAnim1
                        running: false
                        alwaysRunToEnd: true
                        NumberAnimation {
                            from: leftAddrLine.x
                            to: -(leftAddrLine.width * 0.8)
                            duration: 2000
                            easing.type: Easing.OutQuint
                        }
                    }

                    SequentialAnimation on x {
                        id: xAnim2
                        running: false
                        alwaysRunToEnd: true
                        NumberAnimation {
                            from: leftAddrLine.x
                            to: 0
                            duration: 2000
                            easing.type: Easing.OutQuint
                        }
                    }
                }

                /* Layout (2) of choose disk */
                SplitView {
                    id: leftChoose

                    Repeater {
                        id: leftRepeatButt

                        model: {
                            if ((leftChoose.width / diskP1.getListLength(
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
                                if ((leftChoose.width / diskP1.getListLength(
                                         )) > lengthBut)
                                    leftChoose.width / diskP1.getListLength()
                                else
                                    lengthBut
                            }
                            Layout.minimumWidth: {
                                if ((leftChoose.width / diskP1.getListLength(
                                         )) > lengthBut)
                                    leftChoose.width / diskP1.getListLength()
                                else
                                    lengthBut
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    /* Change disk */
                                    var x = leftTabView.getTab(
                                                leftTabView.currentIndex).children[0].data[4]
                                    x.changeDir(diskP1.diskList[index])
                                    /* Set disk path */
                                    leftAddr.text = diskP1.diskList[index]
                                    /* Return to origin state */
                                    leftAddrLine.pop(true)
                                }
                            }
                        }
                    }
                }
            }

            /* Table of views (2 tabs) */
            TabView {
                /* First tab */
                id: leftTabView
                //var clipboard = []
                Tab {
                    title: "Tab 1"
                    Component {
                        id: leftFirstTab
                        TableView {
                            style: TableViewStyle{
                                backgroundColor: Qt.rgba(backgroundColorOfBothPanelsRed,backgroundColorOfBothPanelsGreen,backgroundColorOfBothPanelsBlue, 1)
                                alternateBackgroundColor: Qt.rgba(backgroundColorOfBothPanelsRed-0.05,backgroundColorOfBothPanelsGreen-0.05,backgroundColorOfBothPanelsBlue-0.05, 1)
                                textColor: Qt.rgba(backgroundTextColorOfBothPanelsRed,backgroundTextColorOfBothPanelsGreen,backgroundTextColorOfBothPanelsBlue,1)
                                headerDelegate: Rectangle {
                                    height: textItem.implicitHeight * 1.2
                                    width: textItem.implicitWidth
                                    color: "#777"
                                    Text {
                                        id: textItem
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: styleData.textAlignment
                                        anchors.leftMargin: 12
                                        text: styleData.value
                                        color: "#ddd"
                                    }
                                    Rectangle {
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 1
                                        anchors.topMargin: 1
                                        width: 1
                                        color: "#ccc"
                                    }
                                }
                            }

                            onClicked: {
                                var pattern = /^.*\.(png|jpg|jpeg|JPG|PNG|JPEG)/;
                                if(pattern.test(getCurrentRow())){
                                    background.opacity = 0.3
                                    backgroundSourceLeft = "file:" + leftAddr.text + "/" +  getCurrentRow()
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
                                anchors.topMargin: 18
                                anchors.rightMargin: 22
                                anchors.leftMargin: 22
                                anchors.bottomMargin: 20

                                source: backgroundSourceLeft
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
                                width: (parent.width / 2)-22
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
                                        copyCutFromTo(getLeftTab(), getRightTab(), false)
                                        console.log('Copy')

                                        event.accepted = true
                                    }
                                }
                                if (event.modifiers & Qt.AltModifier) {
                                    // ALT + ->
                                    if (event.key === Qt.Key_Right) {
                                        copyCutFromTo(getLeftTab(), getRightTab(), true)
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
                                        backgroundSourceLeft = "file:" + leftAddr.text + "/" +  getCurrentRow()
                                    }
                                    else{
                                        background.opacity = 0.0
                                    }
                                }
                            }

                            Directory {
                                id: leftTabDir
                            }

                            model: {
                                leftTabDir.files
                            }

                            onActivated: {
                                leftTabDir.changeDir(
                                            leftTabDir.getDir(
                                                ) + "/" + model[currentRow].wholeName)
                                leftAddr.text = leftTabDir.getDir()

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
                        var x = leftTabView.getTab(
                                    leftTabView.currentIndex).children[0].data[4]
                        leftAddr.text = x.getDir()
                    }

                    onActiveFocusChanged: {
                        var x = leftTabView.getTab(
                                    leftTabView.currentIndex).children[0].data[4]
                        leftAddr.text = x.getDir()
                    }

                }

                /* Tab plus */
                Tab {
                    title: "+"
                    width: text.width + 24
                    height: 20

                    onActiveChanged: {
                        leftTabView.insertTab(leftTabView.count - 1,
                                         "Tab " + leftTabView.count, leftFirstTab)
                        leftTabView.currentIndex = leftTabView.count - 2

                        var x = leftTabView.getTab(
                                    leftTabView.currentIndex).children[0].data[4]
                        leftAddr.text = x.getDir()
                        console.log("leftFirstTab");
                    }

                    onVisibleChanged: {
                        if (leftTabView.currentIndex == (leftTabView.count - 1)) {
                            leftTabView.insertTab(leftTabView.count - 1,
                                             "Tab " + leftTabView.count, leftFirstTab)
                            leftTabView.currentIndex = leftTabView.count - 2

                            var x = leftTabView.getTab(
                                        leftTabView.currentIndex).children[0].data[4]
                            leftAddr.text = x.getDir()
                            console.log("rightFirstTab");
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
                           id: leftTabHeader
                           visible: {
                               if (leftTabView)
                                   if (leftTabView.count > 2)
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
                                   console.log(leftTabView.currentIndex + "|" + leftTabView.count);

                                   var currentIndex = leftTabView.currentIndex
                                   leftTabView.currentIndex = 0;
                                   if (leftTabView.currentIndex >= 0) {
                                      var x = leftTabView.getTab(
                                              leftTabView.currentIndex).children[0].data[4]
                                      leftAddr.text = x.getDir()
                                   }
                                   leftTabView.removeTab(currentIndex)
                               }
                               onEntered: leftTabHeader.color = "black";
                               onExited: leftTabHeader.color = "grey";
                           }
                       }
                   }
                }
            }
        }

        /* Right window ... will be duplicate of left window */
        SplitView {
            id: rightWindow
            orientation: Qt.Vertical
            width: parent.width / 2
            Layout.minimumWidth: parent.width / 2
            Layout.maximumWidth: parent.width / 2

            /* Address line and button */
            StackView {
                id: rightAddrLine
                initialItem: rightItem
                Layout.minimumHeight: 25
                Layout.maximumHeight: 25

                /* Init layout */
                SplitView {
                    id: rightItem
                    anchors.fill: parent
                    Layout.minimumHeight: 25
                    Layout.maximumHeight: 25

                    /* Address line */
                    TextField {
                        id: rightAddr
                        style: TextFieldStyle{ }
                        placeholderText: "Address here"
                        Layout.minimumWidth: parent.width * 0.75
                        Layout.maximumWidth: parent.width * 0.75

                        onEditingFinished: {
                            var x = rightTabView.getTab(
                                    rightTabView.currentIndex).children[0].data[4]
                                    x.changeDir(rightAddr.text)
                        }
                    }

                    /* Change disk */
                    Button {
                        id: rightButton
                        text: "Change disk"
                        visible: true

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                /* If animations are complete */
                                if (xAnim3.running == false)
                                    if (xAnim4.running == false)
                                        if (rightAddrLine.x == 0) {
                                            xAnim3.start()
                                            //console.log("Anim1 start")
                                        } else {
                                            xAnim4.start()
                                            //console.log("Anim2 start")
                                        }

                                /* Set items visibility for layout 2 */
                                for (var i = 0; i < diskP1.getListLength(
                                         ); i++) {
                                    if (rightRepeatButt.itemAt(i) !== null)
                                        rightRepeatButt.itemAt(i).visible = true
                                }

                                /* Load layout with disk choose */
                                rightAddrLine.push(rightChoose)
                            }
                        }
                    }

                    /* Animations of change layouts */
                    SequentialAnimation on x {
                        id: xAnim3
                        running: false
                        alwaysRunToEnd: true
                        NumberAnimation {
                            from: rightAddrLine.x
                            to: -(rightAddrLine.width * 0.8)
                            duration: 2000
                            easing.type: Easing.OutQuint
                        }
                    }

                    SequentialAnimation on x {
                        id: xAnim4
                        running: false
                        alwaysRunToEnd: true
                        NumberAnimation {
                            from: rightAddrLine.x
                            to: 0
                            duration: 2000
                            easing.type: Easing.OutQuint
                        }
                    }
                }

                /* Layout (2) of choose disk */
                SplitView {
                    id: rightChoose

                    Repeater {
                        id: rightRepeatButt

                        model: {
                            if ((rightChoose.width / diskP1.getListLength(
                                     )) > lengthBut)
                                diskP6.getListLength()
                            else {
                                3
                            }
                        }

                        Button {
                            text: diskP1.diskList[index]
                            visible: false

                            Layout.maximumWidth: {
                                if ((rightChoose.width / diskP1.getListLength(
                                         )) > lengthBut)
                                    rightChoose.width / diskP1.getListLength()
                                else
                                    lengthBut
                            }
                            Layout.minimumWidth: {
                                if ((rightChoose.width / diskP1.getListLength(
                                         )) > lengthBut)
                                    rightChoose.width / diskP1.getListLength()
                                else
                                    lengthBut
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    /* Change disk */
                                    var x = rightTabView.getTab(
                                                rightTabView.currentIndex).children[0].data[4]
                                    x.changeDir(diskP1.diskList[index])
                                    /* Set disk path */
                                    rightAddr.text = diskP1.diskList[index]
                                    /* Return to origin state */
                                    rightAddrLine.pop(true)
                                }
                            }
                        }
                    }
                }
            }

            /* Table of views (2 tabs) */
            TabView {
                /* First tab */
                id: rightTabView
                //var clipboard = []
                Tab {
                    title: "Tab 1"
                    Component {
                        id: rightFirstTab
                        TableView {
                            style: TableViewStyle{
                                backgroundColor: Qt.rgba(backgroundColorOfBothPanelsRed,backgroundColorOfBothPanelsGreen,backgroundColorOfBothPanelsBlue, 1)
                                alternateBackgroundColor: Qt.rgba(backgroundColorOfBothPanelsRed-0.05,backgroundColorOfBothPanelsGreen-0.05,backgroundColorOfBothPanelsBlue-0.05, 1)
                                textColor: Qt.rgba(backgroundTextColorOfBothPanelsRed,backgroundTextColorOfBothPanelsGreen,backgroundTextColorOfBothPanelsBlue,1)
                                headerDelegate: Rectangle {
                                    height: textItem.implicitHeight * 1.2
                                    width: textItem.implicitWidth
                                    color: "#777"
                                    Text {
                                        id: textItem
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: styleData.textAlignment
                                        anchors.leftMargin: 12
                                        text: styleData.value
                                        color: "#ddd"
                                    }
                                    Rectangle {
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 1
                                        anchors.topMargin: 1
                                        width: 1
                                        color: "#ccc"
                                    }
                                }
                            }

                            onClicked: {
                                var pattern = /^.*\.(png|jpg|jpeg|JPG|PNG|JPEG)/;
                                if(pattern.test(getCurrentRow())){
                                    background.opacity = 0.3
                                    backgroundSourceRight = "file:" + rightAddr.text + "/" +  getCurrentRow()
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
                                anchors.topMargin: 18
                                anchors.rightMargin: 22
                                anchors.leftMargin: 22
                                anchors.bottomMargin: 20

                                source: backgroundSourceRight
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
                                width: (parent.width / 2)-22
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
                                    if (event.key === Qt.Key_Left) {
                                        copyCutFromTo(getRightTab(), getLeftTab(), false)
                                        console.log('Copy')

                                        event.accepted = true
                                    }
                                }
                                if (event.modifiers & Qt.AltModifier) {
                                    // ALT + ->
                                    if (event.key === Qt.Key_Left) {
                                        copyCutFromTo(getRightTab(), getLeftTab(), true)
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
                                        backgroundSourceRight = "file:" + rightAddr.text + "/" +  getCurrentRow()
                                    }
                                    else{
                                        background.opacity = 0.0
                                    }
                                }
                            }

                            Directory {
                                id: rightTabDir
                            }

                            model: {
                                rightTabDir.files
                            }

                            onActivated: {
                                rightTabDir.changeDir(
                                            rightTabDir.getDir(
                                                ) + "/" + model[currentRow].wholeName)
                                rightAddr.text = rightTabDir.getDir()

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
                        var x = rightTabView.getTab(
                                    rightTabView.currentIndex).children[0].data[4]
                        rightAddr.text = x.getDir()
                    }

                    onActiveFocusChanged: {
                        var x = rightTabView.getTab(
                                    rightTabView.currentIndex).children[0].data[4]
                        rightAddr.text = x.getDir()
                    }

                }

                /* Tab plus */
                Tab {
                    title: "+"
                    width: text.width + 24
                    height: 20

                    onActiveChanged: {
                        rightTabView.insertTab(rightTabView.count - 1,
                                         "Tab " + rightTabView.count, rightFirstTab)
                        rightTabView.currentIndex = rightTabView.count - 2

                        var x = leftTabView.getTab(
                                    leftTabView.currentIndex).children[0].data[4]
                        leftAddr.text = x.getDir()
                        console.log("rightFirstTab");
                    }

                    onVisibleChanged: {
                        if (rightTabView.currentIndex == (rightTabView.count - 1)) {
                            rightTabView.insertTab(rightTabView.count - 1,
                                             "Tab " + rightTabView.count, leftFirstTab)
                            rightTabView.currentIndex = rightTabView.count - 2

                            var x = rightTabView.getTab(
                                        rightTabView.currentIndex).children[0].data[4]
                            rightAddr.text = x.getDir()
                            console.log("rightFirstTab");
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
                       implicitWidth: Math.max(text2.width + 24, 80)
                       implicitHeight: 20
                       radius: 2
                       Text {
                           id: text2
                           anchors.left: parent.left
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.leftMargin: 6
                           text: styleData.title
                           color: styleData.selected ? "white" : "black"
                       }

                       Rectangle {
                           id: rightTabHeader
                           visible: {
                               if (rightTabView)
                                   if (rightTabView.count > 2)
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
                                   console.log(rightTabView.currentIndex + "|" + rightTabView.count);

                                   var currentIndex = rightTabView.currentIndex
                                   rightTabView.currentIndex = 0;
                                   if (rightTabView.currentIndex >= 0) {
                                      var x = rightTabView.getTab(
                                              rightTabView.currentIndex).children[0].data[4]
                                      rightAddr.text = x.getDir()
                                   }
                                   rightTabView.removeTab(currentIndex)
                               }
                               onEntered: rightTabHeader.color = "black";
                               onExited: rightTabHeader.color = "grey";
                           }
                       }
                   }
                }
            }
        }
    }

    /* */
    statusBar: StatusBar {
        id:statusBar
        style: StatusBarStyle{
            background: Rectangle{color: Qt.rgba(backgroundColorOfWholeAppRed,backgroundColorOfWholeAppGreen,backgroundColorOfWholeAppBlue, 1)}
        }
        RowLayout {
            width: parent.width
            Label {
                id: label
                text: ""
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
