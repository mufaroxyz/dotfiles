pragma Singleton
import QtQuick

QtObject {
    property string fontFamily: "Inter Tight"
    property int fontWeightHeader: 600
    property int fontWeightBody: 400
    property real textPrimaryOpacity: 1.0
    property real textSecondaryOpacity: 0.72

    property int fontSizeSmall: 12
    property int fontSizeMedium: 14
    property int fontSizeLarge: 18

    property int padSmall: 8
    property int padMedium: 16
    property int radiusGlobal: 14

    property int animFast: 150
    property int animSmooth: 300

    property color surface: Qt.rgba(30 / 255, 30 / 255, 46 / 255, 0.4)
    property color surfaceText: "#ffffff"
    property color borderGlass: Qt.rgba(1, 1, 1, 0.1)
}
