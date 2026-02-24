import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../core" as Core

PanelWindow {
    id: root

    property int wallpaperRevision: 0
    property string pendingSource: ""
    property Image activeImage: primaryImage

    function wallpaperSourceForRevision(revision) {
        return "../assets/current_wallpaper?rev=" + revision
    }

    function refreshWallpaper() {
        wallpaperRevision = wallpaperRevision + 1
        pendingSource = wallpaperSourceForRevision(wallpaperRevision)

        const nextImage = activeImage === primaryImage ? secondaryImage : primaryImage
        nextImage.loadWallpaper(pendingSource)
    }

    WlrLayershell.layer: WlrLayer.Background

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    FileView {
        path: Qt.resolvedUrl("../assets/current_wallpaper.stamp")
        printErrors: false
        watchChanges: true
        onLoaded: root.refreshWallpaper()
        onFileChanged: root.refreshWallpaper()
    }

    Rectangle {
        anchors.fill: parent
        color: Core.Theme.surface
    }

    component WallpaperLayer: Image {
        id: layer

        property string requestedSource: ""

        function loadWallpaper(nextSource) {
            requestedSource = nextSource
            source = nextSource
        }

        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
        opacity: 0
        scale: 1.02

        states: State {
            name: "visible"
            when: root.activeImage === layer

            PropertyChanges {
                layer.opacity: 1
                layer.scale: 1
            }
        }

        transitions: Transition {
            NumberAnimation {
                target: layer
                properties: "opacity,scale"
                duration: Core.Theme.animSmooth
                easing.type: Easing.OutExpo
            }
        }

        onStatusChanged: {
            if (status === Image.Ready && requestedSource === root.pendingSource)
                root.activeImage = layer
        }
    }

    WallpaperLayer {
        id: primaryImage
    }

    WallpaperLayer {
        id: secondaryImage
    }
}
