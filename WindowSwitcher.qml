import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import "colors" as Palette

PanelWindow {
    anchors.top: true
    margins.top: 8
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    implicitWidth: row.implicitWidth + 16
    implicitHeight: 48
    visible: ToplevelManager.toplevels.values.length > 0

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: Qt.alpha(Palette.Mocha.base, 0.9)

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 6

            Repeater {
                model: ToplevelManager.toplevels

                delegate: Rectangle {
                    required property var modelData
                    width: 36
                    height: 36
                    radius: 10
                    color: modelData.activated ? Palette.Mocha.surface1 : hover.hovered ? Palette.Mocha.surface0 : "transparent"

                    function icon(id) {
                        const e = DesktopEntries.heuristicLookup(id);
                        return Quickshell.iconPath(e ? e.icon : id, "application-x-executable");
                    }

                    IconImage {
                        anchors.centerIn: parent
                        implicitSize: 24
                        source: parent.icon(parent.modelData.appId)
                    }

                    HoverHandler { id: hover }
                    TapHandler { onTapped: modelData.activate() }
                }
            }
        }
    }
}