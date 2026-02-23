import QtQuick
import Quickshell
import "core" as Core

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
        border.color: Core.Theme.borderGlass
        radius: Core.Theme.radiusGlobal

        Text {
            anchors.centerIn: parent
            text: "Akane OS"
            color: Core.Theme.surfaceText
            font.family: Core.Theme.fontFamily
            font.weight: Core.Theme.fontWeightHeader
            font.pixelSize: Core.Theme.fontSizeMedium
            opacity: Core.Theme.textPrimaryOpacity
        }
    }
}
