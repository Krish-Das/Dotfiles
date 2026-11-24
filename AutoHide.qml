// ~/.config/quickshell/shell.qml
import Quickshell
import QtQuick

Scope {
    id: root

    // --- Tunables ---
    readonly property int triggerHeight: 2    // px, use 2 if hard to hit
    readonly property int triggerWidth: 220   // px
    readonly property int pillHeight: 36      // px
    readonly property int pillWidth: 120      // px
    readonly property int pillTopMargin: 8    // px
    readonly property int showDelay: 300      // ms, dwell before show
    readonly property int hideDelay: 400      // ms, grace before hide

    // --- State ---
    property bool shown: false

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Timer {
        id: showTimer
        interval: root.showDelay
        onTriggered: root.shown = true
    }

    Timer {
        id: hideTimer
        interval: root.hideDelay
        onTriggered: root.shown = false
    }

    function triggerHovered(hovered) {
        if (hovered) {
            hideTimer.stop();
            if (!shown)
                showTimer.restart();
        } else {
            showTimer.stop();
            hideTimer.restart();
        }
    }

    function pillHovered(hovered) {
        if (hovered)
            hideTimer.stop();
        else
            hideTimer.restart();
    }

    // Invisible trigger strip, top center
    PanelWindow {
        anchors.top: true
        exclusiveZone: 0
        color: "transparent"
        implicitHeight: root.triggerHeight
        implicitWidth: root.triggerWidth

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: root.triggerHovered(true)
            onExited: root.triggerHovered(false)
        }
    }

    // The pill
    PanelWindow {
        visible: root.shown
        anchors.top: true
        margins.top: root.pillTopMargin
        exclusiveZone: 0
        color: "transparent"
        implicitHeight: root.pillHeight
        implicitWidth: root.pillWidth

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: "#cc1e1e2e"
            border.color: "#40ffffff"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, "HH:mm")
                color: "#e0e0e0"
                font.pixelSize: 15
                font.family: "sans-serif"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: root.pillHovered(true)
                onExited: root.pillHovered(false)
            }
        }
    }
}