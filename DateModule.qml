// ~/.config/quickshell/DateModule.qml
import Quickshell
import QtQuick

Scope {
    id: root

    // --- Tunables ---
    readonly property int shiftRange: 2         // px, max X offset each side
    readonly property int shiftInterval: 60000  // ms, time between 1 px steps
    readonly property int edgeMargin: 8         // px, gap to screen edges

    // --- State ---
    property int offset: 0
    property int direction: 1

    SystemClock {
        id: clock
        precision: SystemClock.Hours   // the date changes once per day
    }

    // Offset path: 0 → 2 → -2 → 2 ... in 1 px steps
    Timer {
        interval: root.shiftInterval
        running: true
        repeat: true
        onTriggered: {
            root.offset += root.direction;
            if (Math.abs(root.offset) >= root.shiftRange)
                root.direction = -root.direction;
        }
    }

    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: root.edgeMargin
            right: root.edgeMargin + root.offset
        }
        exclusiveZone: 0
        color: "transparent"
        implicitHeight: 36
        implicitWidth: label.implicitWidth + 32

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: "#cc1e1e2e"
            border.color: "#40ffffff"
            border.width: 1

            Text {
                id: label
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, "ddd d MMM")
                color: "#e0e0e0"
                font.pixelSize: 15
                font.family: "sans-serif"
            }
        }
    }
}