import QtQuick
import Quickshell
import Quickshell.Io

// Headless service: runs bin/cursor-shake for the plugin's lifetime. That
// script polls the cursor position itself, so there's nothing for this file
// to do beyond keeping the process alive and restarting it if it ever dies.
Item {
  id: root

  readonly property string script: Qt.resolvedUrl("bin/cursor-shake").toString().replace("file://", "")

  Process {
    id: proc
    command: [root.script]
    running: true
    onExited: restart.start()
  }

  Timer {
    id: restart
    interval: 2000
    onTriggered: proc.running = true
  }
}
