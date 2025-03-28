import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    Image {
        // By url to file
        source: "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/background1.png"
        anchors.fill: parent // Fill parent(parent is ApplicationWindow(
        fillMode: Image.PreserveAspectCrop // Keep aspect of size if cropped png
    }

    // Instruction text
    Text {
        x: 50 // X coordinate
        y: 100 // Y coordinate
        width: 1000 // Width
        height: 500 // Height
        text: instructionObject.gameInstructions
        font.pixelSize: 42
         font.bold: true // Bold font for emphasis
        color: "#f5f113" // Text color
        wrapMode: Text.Wrap
    }

    Button {
        text: "Back" // Button label
        x: 20 // X coordinate
        y: 20 // Y coordinate
        width: 100 // Button width
        height: 50 // Button height
        onClicked: {
            stackView.pop() // Return to previous page
        }
        contentItem: Text {
            text: parent.text // Use button's text
            font.pixelSize: 20 // Font size set to 20
            color: "#151818" // Text color
            horizontalAlignment: Text.AlignHCenter // Center text horizontally
            verticalAlignment: Text.AlignVCenter // Center text vertically
        }
        background: Rectangle {
            color: "#f5f113" // Background color
            opacity: 0.6 // 60% transparency
            border.width: 2 // 2px frame around button
            border.color: "#151818" // Frame colour
        }
    }
}

