import QtQuick
import QtQuick.Controls 6.7
import QtQuick.Layouts

Window
{
    id: root
    width: 300
    height: 480
    minimumWidth: 300
    minimumHeight: 480
    maximumWidth: 300
    maximumHeight: 480
    visible: true
    title: qsTr("Calculator")
    color: "#024873"

    StackView
    {
        id: stackView
        anchors.fill: parent
        initialItem: calculatorPage
    }

    Rectangle
    {
        id: rectangle
        x: 0
        y: 0
        width: 300
        height: 24
        color: "#1abc9c"

        Image
        {
            id: statusBarImage
            source: "qrc:images/status_bar_contents.png"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            height: parent.height
        }
    }

    Component
    {
        id: calculatorPage

        Item
        {
            id: page
            anchors.fill: parent



            Connections {
                target: calculator

                function onExpressionChanged()
                {
                    expressionLabel.text = calculator.expression
                }

                function onResultChanged()
                {
                    resultLabel.text = calculator.result
                }

                function onSymbolAppended(symbol)
                {
                    secretInput.addSymbol(symbol)
                }
            }

            ColumnLayout
            {
                anchors.fill: parent
                spacing: 12

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    radius: 20
                    color: "#1abc9c"

                    Column
                    {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 16
                        spacing: 6

                        Text
                        {
                            id: expressionLabel
                            text: calculator.expression
                            anchors.right: parent.right
                            font.pixelSize: 20
                            color: "white"
                            clip: true

                        }

                        Text
                        {
                            id: resultLabel
                            text: calculator.result
                            anchors.right: parent.right
                            font.pixelSize: 36
                            font.bold: true
                            color: "white"
                            clip: true

                        }
                    }
                }

                Item
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    GridLayout
                    {
                        id: buttonGrid
                        anchors.centerIn: parent
                        columns: 4
                        rowSpacing: 8
                        columnSpacing: 8

                        CircleSymbolButton { text: "()"; normalColor: "#0889A6"; onClicked: calculator.appendParentheses() }
                        CircleSymbolButton { text: "+/-"; normalColor: "#0889A6"; onClicked: calculator.changeArithmeticSign() }
                        CircleSymbolButton { text: "%"; normalColor: "#0889A6"; onClicked: calculator.toPercent() }
                        CircleSymbolButton { text: "÷"; normalColor: "#0889A6"; onClicked: calculator.appendSymbol("/") }

                        CircleButton { text: "7"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("7") }
                        CircleButton { text: "8"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("8") }
                        CircleButton { text: "9"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("9") }
                        CircleSymbolButton { text: "×"; normalColor: "#0889A6"; onClicked: calculator.appendSymbol("*") }

                        CircleButton { text: "4"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("4") }
                        CircleButton { text: "5"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("5") }
                        CircleButton { text: "6"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("6") }
                        CircleSymbolButton { text: "−"; normalColor: "#0889A6"; onClicked: calculator.appendSymbol("-") }

                        CircleButton { text: "1"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("1") }
                        CircleButton { text: "2"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("2") }
                        CircleButton { text: "3"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("3") }
                        CircleSymbolButton { text: "+"; normalColor: "#0889A6"; onClicked: calculator.appendSymbol("+") }

                        CircleButton { text: "C"; normalColor: "pink"; textColor: "white"; pressedColor: "red"; onClicked: calculator.clear() }
                        CircleButton { text: "0"; normalColor: "#B0D1D8"; onClicked: calculator.appendSymbol("0") }
                        CircleSymbolButton { text: "."; normalColor: "#0889A6"; onClicked: calculator.appendSymbol(".") }

                        CircleSymbolButton {
                            id: equalButton
                            text: "="
                            normalColor: "#0889A6"

                            Timer {
                                id: longPressTimer
                                interval: 4000
                                repeat: false
                                onTriggered: {
                                    console.log("Долгое нажатие на '='")
                                    secretInput.active = true
                                    secretInputTimer.start()
                                }
                            }

                            onPressed: longPressTimer.start()
                            onReleased: longPressTimer.stop()
                            onClicked: calculator.calculate()
                        }
                    }
                }
            }

            Item
            {
                id: secretInput
                visible: false
                property bool active: false
                property string buffer: ""

                Timer
                {
                    id: secretInputTimer
                    interval: 5000
                    repeat: false
                    onTriggered:
                    {
                        secretInput.active = false
                        secretInput.buffer = ""
                        console.log("Таймер секретного ввода истёк")
                    }
                }

                function addSymbol(symbol)
                {
                    if (!active)
                        return

                    buffer += symbol
                    console.log("Buffer:", buffer)

                    if (buffer === "123")
                    {
                        active = false
                        buffer = ""
                        stackView.push("SecretMenu.qml", { stackView: stackView })

                        secretInputTimer.stop()
                    }
                }
            }
        }
    }
}
