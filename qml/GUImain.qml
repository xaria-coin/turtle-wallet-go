import QtQuick.Window 2.2
import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window

    property var windowWidth: 1060
    property var windowHeight: 755
    property var minWindowHeight: 500

    Material.accent: Material.Grey

    width: windowWidth
    height: windowHeight
    color: "#333333"
    minimumWidth: windowWidth
    minimumHeight: minWindowHeight
    title: "Xaria GUI"
    visible: true

    Flickable{
        interactive: true
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: windowWidth
        contentHeight: windowHeight
        width: parent.width
        height: parent.height

        ScrollBar.vertical: ScrollBar {
            width: 10
            anchors.right: parent.right
            anchors.rightMargin: 0
            policy: parent.height < windowHeight ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        OpenWallet {
            id: openWalletScreen
            anchors.fill: parent

            Image {
                id: image
                x: 837
                y: 415
                width: 163
                height: 159
                source: "images/xariagui.png"
            }
        }

        Wallet {
            id: walletScreen
        }

        Settings {
            id: settingsScreen
        }
    }

    MessageDialog {
        id: dialogInfo
        title: ""
        text: ""
        standardButtons: StandardButton.Ok

        onAccepted: {
            dialogInfo.title = "";
            dialogInfo.text = "";
            dialogInfo.informativeText = "";
        }

        function show(title, errorText, errorInformativeText) {
            dialogInfo.title = title;
            dialogInfo.text = errorText;
            dialogInfo.informativeText = errorInformativeText;
            dialogInfo.open();
        }

        function showError(errorText, errorInformativeText) {
            dialogInfo.icon = StandardIcon.Warning;
            dialogInfo.show("Error", errorText, errorInformativeText);
        }
    }

    Connections {
        target: QmlBridge

        onDisplayErrorDialog: {
            dialogInfo.showError(errorText, errorInformativeText);
        }

        onDisplayOpenWalletScreen: {
            openWalletScreen.clearData();
            openWalletScreen.enabled = true;
            walletScreen.hide();
        }

        onDisplayMainWalletScreen: {
            walletScreen.clearData();
            walletScreen.show();
            openWalletScreen.enabled = false;
        }

        onDisplaySettingsScreen: {
            settingsScreen.show();
        }

        onHideSettingsScreen: {
            settingsScreen.hide();
        }
    }
}
