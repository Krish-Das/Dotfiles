pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire

Singleton {
  id: root

  QtObject {
    id: priv
    property var sink: Pipewire.defaultAudioSink
  }

  property int volume: priv.sink?.audio
  ? Math.round(priv.sink.audio.volume * 100)
  : -1

  property bool muted: priv.sink?.audio?.muted ?? true

  function toggleMute() {
    muteProc.running = true
  }

  function setVolume(delta) {
    if (delta > 0)
    volumeProc.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05+", "-l", "1.0"]
    else
    volumeProc.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05-"]
    volumeProc.running = true
  }

  PwObjectTracker {
    objects: priv.sink ? [priv.sink] : []
  }

  Process {
    id: muteProc
    command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
  }

  Process {
    id: volumeProc
    command: []
  }
}
