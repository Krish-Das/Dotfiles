import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      WlrLayershell.layer: WlrLayer.Bottom
      WlrLayershell.namespace: "desktop-icons"

      anchors { right: true; top: true }
      margins { right: 24; top: 24 }
      exclusionMode: ExclusionMode.Ignore

      implicitWidth: 56
      implicitHeight: 56
      color: "transparent"

      Image {
        anchors.fill: parent
        source: Quickshell.iconPath("org.wezfurlong.wezterm")
        sourceSize: Qt.size(64, 64)
        fillMode: Image.PreserveAspectFit
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.ArrowCursor
        onClicked: Quickshell.execDetached(["wezterm"])
      }
    }
  }
}
