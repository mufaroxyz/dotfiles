import QtQuick
import Quickshell
import "components" as Components
import "core" as Core

Scope {
    Components.Wallpaper {}

    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 40

        Rectangle {
            anchors.fill: parent
            color: Core.Theme.surface
            border.width: 1
            border.color: Core.Theme.borderHighlight
            radius: Core.Theme.radiusGlobal

            Components.Clock {
                anchors.centerIn: parent
            }
        }
    }
}
