pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string time: ""

  Process {
    id: dateProc
    command: ["date", "+%H:%M:%S 􀅽 %d %h %y"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.time = text.trim().toUpperCase()
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}
