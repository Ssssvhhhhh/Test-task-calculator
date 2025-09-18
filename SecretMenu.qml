import QtQuick 2.15
import QtQuick.Controls 6.7

Page
{
    id: secretPage
    title: "Secret Menu"

    property StackView stackView

    Label
    {
        anchors.centerIn: parent
        text: "Секретное меню"
        font.pointSize: 24
    }

    Button
    {
        text: "Назад"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        onClicked: stackView.pop()
    }
}
