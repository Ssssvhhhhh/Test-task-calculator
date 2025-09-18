import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button
{
    id: root
    property color normalColor: "#B0D1D8"
    property color pressedColor: "#04BFAD"
    property color textColor: "#024873"
    property int fontSize: 20
    property bool bold: true

    Layout.minimumWidth: 50
    Layout.minimumHeight: 50
    Layout.preferredWidth: 57
    Layout.preferredHeight: 57
    hoverEnabled: false

    background: Rectangle
    {
        anchors.fill: parent
        radius: width / 2
        color: root.down ? root.pressedColor : root.normalColor
        border.color: "transparent"
    }

    contentItem: Text
    {
        anchors.fill: parent
        text: root.text
        font.pixelSize: root.fontSize
        font.bold: root.bold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: root.down ? "#FFFFFF" : root.textColor
    }
}
