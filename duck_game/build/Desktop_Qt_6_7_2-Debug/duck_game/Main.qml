import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1280
    height: 800
    title: qsTr("Duck shooter game")

    StackView {//To manage navigation between pages
        id: stackView
        anchors.fill: parent
        initialItem: Item {
            Image {
                //by url to file
                source: "file:///home/krzysiek89/Desktop/QT_aplikacje/Plane_support_app_airport_visualisation/Airport_supp/background.png"
                anchors.fill: parent//fill parent(parent is ApplicationWindow(
                fillMode: Image.PreserveAspectCrop//keep aspect of size if cropped png
            }



            Button {
                id: button1
                text: "Start game"
                x: 100    // X coordinate
                y: 100    // Y coordinate
                width: 250 // Button width
                height: 175 // Button height
                onClicked: {
                    console.log("Start game")
                    stackView.push("qrc:/qt/qml/Airport_supp/AirportPage.qml") //Open page with this view
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
                    color: "#95ede5"    // Background color
                    opacity: 0.6        // 60% transparency
                    border.width: 2 //2px frame around button
                    border.color: "#151818" //Frame colour
                }
            }

            Button {
                id: button2
                text: "Instruction"
                x: 100
                y: 300
                width: 250
                height: 175
                onClicked: {
                    console.log("In the air!")
                    stackView.push("qrc:/qt/qml/Airport_supp/InTheAirPage.qml")
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
                    color: "#95ede5"    // Background color
                    opacity: 0.6        // 60% transparency
                    border.width: 2 //2px frame around button
                    border.color: "#151818" //Frame colour
                }
            }

            Button {
                id: button3
                text: "Exit app!"
                x: 100
                y: 500
                width: 250
                height: 175
                onClicked: {
                    console.log("Exit app")
                    stackView.push("qrc:/qt/qml/Airport_supp/AfterLandingPage.qml")
                }

                // Customize font and appearance
                contentItem: Text {
                    text: button3.text
                    font.pixelSize: 32  // Font size set to 32
                    color: "#151818" //Text color

                    //put text on the middle of button
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: "#95ede5"    // Background color
                    opacity: 0.6        // 60% transparency
                    border.width: 2 //2px frame around button
                    border.color: "#151818" //Frame colour
                }
            }
        }
    }
}
