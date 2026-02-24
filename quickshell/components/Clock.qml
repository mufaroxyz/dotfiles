import QtQuick
import "../core" as Core

Rectangle {
    id: root

    property string clockLabel: ""

    implicitWidth: clockText.implicitWidth + Core.Theme.padMedium * 2
    implicitHeight: clockText.implicitHeight + Core.Theme.padMedium * 2
    radius: Core.Theme.radiusGlobal
    color: Core.Theme.surface
    transformOrigin: Item.Center
    scale: hoverHandler.hovered ? 1.05 : 1.0

    function updateClockLabel() {
        const now = new Date()
        clockLabel = Qt.formatDateTime(now, "HH:mm") + "  " + Qt.formatDateTime(now, "ddd, MMM d")
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.updateClockLabel()
    }

    Component.onCompleted: updateClockLabel()

    Behavior on scale {
        NumberAnimation {
            duration: Core.Theme.animFast
            easing.type: Easing.OutExpo
        }
    }

    HoverHandler {
        id: hoverHandler
    }

    Item {
        anchors.fill: parent
        anchors.margins: Core.Theme.padMedium

        Text {
            id: clockText
            anchors.centerIn: parent
            text: root.clockLabel
            color: Core.Theme.surfaceText
            font.family: Core.Theme.fontFamily
            font.weight: Core.Theme.fontWeightHeader
            font.pixelSize: Core.Theme.fontSizeMedium
            opacity: Core.Theme.textPrimaryOpacity
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
