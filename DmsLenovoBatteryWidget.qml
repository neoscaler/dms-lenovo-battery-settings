import QtQuick
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins
import Quickshell.Io

PluginComponent {
    id: root

    property bool isConservationModeActive: false
    property int refreshInterval: pluginData.refreshInterval || 5
    property string lenovoAcpiId: "/sys/bus/platform/devices/VPC2004:00"
    property string conservationModeAcpiNode: "/conservation_mode"
    property bool hardwareExists: false

    Process {
        id: hardwareCheck
        command: ["test", "-d", root.lenovoAcpiId]
        running: true
        onExited: (code) => { root.hardwareExists = (code === 0) }
    }

    Timer {
        interval: root.refreshInterval * 1000
        running: root.hardwareExists
        repeat: true
        onTriggered: statusCheck.running = true
    }

    Process {
        id: statusCheck
        command: ["cat", root.lenovoAcpiId + root.conservationModeAcpiNode]
        running: root.hardwareExists

        property string caller: ""

        stdout: StdioCollector {
            id: outputCollector
            onStreamFinished: {
                if (this.text == 0) {
                    isConservationModeActive = false;
                } else if (this.text == 1) {
                    isConservationModeActive = true;
                } else {
                    ToastService.showError("Can't determine conservation mode status.");
                }
                statusCheck.running = false;
            }
        }

        onExited: {
            if (caller == "toggle") {
                const output = root.isConservationModeActive ? "Conservation mode enabled" : "Conservation mode disabled";
                ToastService.showInfo(output);
            }
            caller = "";
        }
    }

    Process {
        id: toggleProcess

        onExited: (code, status) => {
            statusCheck.caller = "toggle";
            statusCheck.running = true;
        }
    }

    function toggleConservationMode() {
        const targetValue = root.isConservationModeActive ? "0" : "1"
        toggleProcess.command = ["pkexec", "sh", "-c", `echo ${targetValue} > ${root.lenovoAcpiId}${root.conservationModeAcpiNode}`];
        toggleProcess.running = true;
    }

    horizontalBarPill: Component {
        MouseArea {
            implicitWidth: contentRow.implicitWidth
            implicitHeight: contentRow.implicitHeight
            cursorShape: Qt.PointingHandCursor
            onClicked: toggleConservationMode()

            Row {
                id: contentRow
                spacing: Theme.spacingS

                DankIcon {
                    name: root.isConservationModeActive ? "battery_android_frame_shield" : "battery_android_shield"
                    size: Theme.iconSize - 6
                    color: root.isConservationModeActive ? Theme.primary : Theme.surfaceText
                    anchors.verticalCenter: parent.verticalCenter
                    visible: root.showIcon
                }
            }
        }
    }

    verticalBarPill: Component {
        MouseArea {
            implicitWidth: contentRow.implicitWidth
            implicitHeight: contentRow.implicitHeight
            cursorShape: Qt.PointingHandCursor
            onClicked: toggleConservationMode()

            Column {
                id: contentColumn
                spacing: Theme.spacingS

                DankIcon {
                    name: root.isConservationModeActive ? "battery_android_frame_shield" : "battery_android_shield"
                    size: Theme.iconSize - 6
                    color: root.isConservationModeActive ? Theme.primary : Theme.surfaceText
                    anchors.verticalCenter: parent.verticalCenter
                    visible: root.showIcon
                }
            }
        }
    }
}