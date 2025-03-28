import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root // Define the root id for this Item so it can be referenced
    width: 1280 // Set explicit width to match hunter movement limits
    height: 700 // Set explicit height to match hunter's y position
    Image {
        //by url to file
        source: "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/background1.png"
        anchors.fill: parent// Fill parent(parent is ApplicationWindow(
        fillMode: Image.PreserveAspectCrop// Keep aspect of size if cropped png
    }

    Image {
        id: hunter
        source: "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/hunter.png"
        x: hunterObject.xPos // Object(with image) is on surrent fnter pos
        y: 700 - height // 700px down from top edge of screen, adjusted to sit at bottom
        width: hunterObject.width //Size is equal to constructor value
        height: hunterObject.height
        fillMode: Image.PreserveAspectFit
    }

    focus: true                 // Ensures this component receives keyboard input
    Keys.onPressed: {           // Event handler for key presses
        switch (event.key) {    // Switch statement to handle different key inputs
        case Qt.Key_A:      // When 'A' key is pressed
        case Qt.Key_Left:   // When Left Arrow key is pressed
            hunterObject.moveLeft(); // Call the moveLeft slot to move hunter left
            break;
        case Qt.Key_D:      // When 'D' key is pressed
        case Qt.Key_Right:  // When Right Arrow key is pressed
            hunterObject.moveRight(); // Call the moveRight slot to move hunter right
            break;
        case Qt.Key_Space:  // When Spacebar is pressed
            console.log("Shoot!"); // Log a message as a placeholder for shooting logic
            hunterObject.shoot(); // Trigger the shoot slot in Hunter class
            break;
        }
    }

    // Bullet component
    Component {
        id: bulletComponent
        Rectangle {
            width: 20 // Diameter of 20px (radius 10px)
            height: 20
            radius: 10 // Makes it a circle
            color: "red" // Visual representation of the bullet
            y: 0 // Will be set dynamically
            x: 0 // Will be set dynamically

            // Define the behavior for the y property when it changes
            Behavior on y {
                // Animation to smoothly move the bullet upward
                NumberAnimation {
                    duration: (100 * 1000) / 100 // Duration in milliseconds: 100px distance at 100px/s = 1000ms (1 second)
                    // Calculation: (distance * 1000) / speed, here 100px takes 1s

                    easing.type: Easing.Linear // Use linear easing for constant speed, no acceleration or deceleration

                    // Event handler triggered when the animation starts or stops
                    onRunningChanged: {
                        // Check if animation has stopped (running = false) and bullet reached the top (y <= 0)
                        if (!running && y <= 0) {
                            destroy(); // Destroy the bullet object to free memory when it reaches the top of the screen
                        }
                    }
                }
            }
        }
    }

    // Connect the shotFired signal to spawn a bullet
    Connections {
        target: hunterObject
        function onShotFired(x, y) {
            var bullet = bulletComponent.createObject(root, {"x": x, "y": y});
            bullet.y = y - 700; // Animate from starting y to top (y=0), 700px travel distance
        }
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
