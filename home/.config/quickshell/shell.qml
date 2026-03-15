import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
  anchors {
    bottom: true; left: true; right: true
  }
  implicitHeight: 22
  color: "#99000000"

  Text {
    anchors.centerIn: parent
    font.pixelSize: 12
    font.family: "JetBrains Mono"
    color: "#EBEBF5"
    text: DateTime.time
  }

  Text {
    anchors {
      right: parent.right
      rightMargin: 12
      verticalCenter: parent.verticalCenter
    }
    font.pixelSize: 12
    font.family: "JetBrains Mono"
    property bool available: Audio.volume >= 0
    property string icon: {
      if (!available || Audio.muted) return "􀊢"
      if (Audio.volume < 33) return "􀊤"
      if (Audio.volume < 66) return "􀊦"
      return "􀊨"
    }
    color: !available || Audio.muted ? "#FF4245" : "#EBEBF5"
    property string volume: available ? Audio.volume + "%" : "--"
    text: {
      return `${icon} ${volume}`
    }

    MouseArea {
      anchors.fill: parent
      onClicked: Audio.toggleMute()
      onWheel: (event) => Audio.setVolume(event.angleDelta.y)
    }
  }
}
