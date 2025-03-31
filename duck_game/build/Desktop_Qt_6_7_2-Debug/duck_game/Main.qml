import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1280
    height: 800
    title: qsTr("Duck shooter game")

    StackView { // To manage navigation between pages
        id: stackView
        anchors.fill: parent
        initialItem: Item {
            Image {
                //by url to file
                source: "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/background.png"
                anchors.fill: parent // Fill parent(parent is ApplicationWindow(
                fillMode: Image.PreserveAspectCrop // Keep aspect of size if cropped png
            }



            Button {
                id: button1
                text: "Start game"
                x: 30    // X coordinate
                y: 30    // Y coordinate
                width: 200 // Button width
                height: 140 // Button height
                onClicked: {
                    stackView.push("qrc:/qt/qml/duck_game/game.qml") //Open page with this view
                }

                // Customize font and appearance
                contentItem: Text {
                    text: button1.text
                    font.pixelSize: 32  // Font size set to 32
                    color: "#151818" //Text color

                    //put text on the middle of button
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: "#e5e38d"    // Background color
                    opacity: 0.6        // 60% transparency
                    border.width: 2 //2px frame around button
                    border.color: "#151818" //Frame colour
                }
            }

            Button {
                id: button2
                text: "Instruction"
                x: 30
                y: 200
                width: 200
                height: 140
                onClicked: {
                    stackView.push("qrc:/qt/qml/duck_game/Instruction.qml")
                }

                // Customize font and appearance
                contentItem: Text {
                    text: button2.text
                    font.pixelSize: 32  // Font size set to 32
                    color: "#151818" //Text color

                    //put text on the middle of button
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: "#e5e38d"    // Background color
                    opacity: 0.6        // 60% transparency
                    border.width: 2 //2px frame around button
                    border.color: "#151818" //Frame colour
                }
            }

            Button {
                id: button3
                text: "Exit app!"
                x: 30
                y: 370
                width: 200
                height: 140
                onClicked: {
                    Qt.quit();//qui app
                }

                // Customize font and appearance
                contentItem: Text {
                    text: button3.text
                    font.pixelSize: 32  // Font size set to 32
                    color: "#151818" //Text color

                    // Put text on the middle of button
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: "#e5e38d"    // Background color
                    opacity: 0.6        // 60% transparency
                    border.width: 2 // 2px frame around button
                    border.color: "#151818" // Frame colour
                }
            }
        }
    }
}
