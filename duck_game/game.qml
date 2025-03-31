import QtQuick 2.15         // Core library for QML UI elements
import QtQuick.Controls 2.15 // Additional QML controls like Button

Item {
    id: root // Unique identifier for this Item, used as the parent for all game elements
    width: 1280 // Fixed width of the game window in pixels
    height: 700 // Fixed height of the game window in pixels


    Component.onCompleted: {
        gameObject.resetGame() // Reset while start
        gameLoopTimer.running = true // Start game loop
        gameOverText.visible = false // Hide "You lost!"
    }

    Image {
        // Background image for the game
        source: "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/background1.png"
        anchors.fill: parent    // Fills the entire parent (root) area
        fillMode: Image.PreserveAspectCrop // Crops image to fit while preserving aspect ratio
    }

    Image {
        id: hunter              // Hunter sprite representing the player
        source: "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/hunter.png"
        x: hunterObject.xPos    // X position synced with Hunter class
        y: 700 - height         // Positioned at the bottom of the screen (700 - hunter height)
        width: hunterObject.width // Width from Hunter class
        height: hunterObject.height // Height from Hunter class
        fillMode: Image.PreserveAspectFit // Scales image to fit while preserving aspect ratio
    }

    // Score display
    Text {
        id: scoreText           // Identifier for the score text element
        text: "Score: " + gameObject.score // Display current score from Game class
        font.pixelSize: 36      // Font size in pixels
        color: "white"          // White text color for visibility on background
        anchors.top: parent.top // Position at the top of the screen
        anchors.right: parent.right // Align to the right edge
        anchors.margins: 30     // 10-pixel margin from top and right edges
    }

    // Game over display
    Text {
            id: gameOverText
            text: "You lost!\nScore: " + gameObject.score // And show points which you collected
            font.pixelSize: 84
            color: "red"
            anchors.centerIn: parent
            visible: false // Hide (if not lost, when lost show - make vissible)
            horizontalAlignment: Text.AlignHCenter
        }


    // Duck component
    Component {
        id: duckComponent       // Identifier for the duck template
        Image {
            id: duck            // Unique ID for each duck instance
            property int duckId: -1 // Unique ID assigned by C++ to track this duck
            property int duckType: 1 // Type of duck (1, 2, or 3) for different visuals
            // Select image based on duck type
            source: duckType === 1 ? "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/duck1.png" :
                    duckType === 2 ? "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/duck2.png" :
                                     "file:///home/krzysiek89/Desktop/QT_aplikacje/QML_Duck_shooter/duck_game/duck3.png"
            width: 80           // Duck width in pixels
            height: 80          // Duck height in pixels
            fillMode: Image.PreserveAspectFit // Scales image to fit while preserving aspect ratio
        }
    }

    // Bullet component: defines how bullets are visually represented
    Component {
        id: bulletComponent     // Identifier for the bullet template
        Rectangle {
            id: bullet          // Unique ID for each bullet instance
            property int bulletId: -1 // Unique ID to track this bullet
            width: 20           // Bullet width (diameter) in pixels
            height: 20          // Bullet height in pixels
            radius: 10          // Makes it a circle (radius = half of width)
            color: "red"        // Red color for bullet visibility
        }
    }

    // Object map: JavaScript object to store references to all active game objects by their IDs
    property var objectMap: ({})

    // Connects DuckSpawner signal to the Game class
    Connections {
        target: duckSpawner     // The DuckSpawner object registered in main.cpp
        function onSpawnDuck(x, type) { // When DuckSpawner emits spawnDuck signal
            gameObject.spawnDuck(x, type) // Forward the spawn request to Game class
        }
    }

    // Connects Game signals from C++ to QML for visual updates
    Connections {
        target: gameObject      // The Game object registered in main.cpp
        function onDuckSpawned(id, x, y, type) { // When a duck is spawned
            // Create a new duck instance with given properties
            var duck = duckComponent.createObject(root, {"duckId": id, "x": x, "y": y, "duckType": type})
            objectMap[id] = duck // Store the duck in the map for later updates
        }
        function onBulletSpawned(id, x, y) { // When a bullet is spawned
            // Create a new bullet instance with given properties
            var bullet = bulletComponent.createObject(root, {"bulletId": id, "x": x, "y": y})
            objectMap[id] = bullet // Store the bullet in the map for later updates
        }
        function onUpdatePosition(id, x, y) { // When an object's position changes
            if (objectMap[id]) {    // Check if the object exists in the map
                objectMap[id].x = x // Update its x position
                objectMap[id].y = y // Update its y position
            }
        }
        function onObjectDestroyed(id) { // When an object is destroyed
            if (objectMap[id]) {    // Check if the object exists in the map
                objectMap[id].destroy() // Remove it from the QML scene
                delete objectMap[id] // Remove it from the map to free memory
            }
        }
        function onGameOver() {
                    gameLoopTimer.running = false // Stop game loop
                    gameOverText.visible = true   // Show "You lost!"
                    returnToMenuTimer.start()     // Start back to menu timer
                }
    }

    // Timer to drive the game loop
    Timer {
        id: gameLoopTimer
        interval: 16            // Update every 16 milliseconds (~60 FPS)
        running: true           // Start immediately when QML loads
        repeat: true            // Keep running continuously
        onTriggered: gameObject.updateGame() // Call updateGame  to move objects and check collisions
    }

    // Go back to menu after 5 sec
        Timer {
            id: returnToMenuTimer
            interval: 5000 // 5 sec
            running: false
            repeat: false
            onTriggered: {
                stackView.pop() // Return to main menu
            }
        }

    focus: true                 // Ensure this Item receives keyboard input
    Keys.onPressed: {           // Handle keyboard input
        switch (event.key) {
        case Qt.Key_A:          // 'A' key
        case Qt.Key_Left:       // Left arrow key
            hunterObject.moveLeft() // Move hunter left via Hunter class
            break
        case Qt.Key_D:          // 'D' key
        case Qt.Key_Right:      // Right arrow key
            hunterObject.moveRight() // Move hunter right via Hunter class
            break
        case Qt.Key_Space:      // Spacebar
            hunterObject.shoot() // Trigger shooting via Hunter class
            break
        }
    }

    // Connects Hunter's shotFired signal to spawn a bullet
    Connections {
        target: hunterObject    // The Hunter object registered in main.cpp
        function onShotFired(x, y) { // When hunter shoots
            gameObject.shootBullet(x, y) // Forward the shot to Game class to spawn a bullet
        }
    }

    Button {
        text: "Back"            // Button label
        x: 20                   // X position in pixels
        y: 20                   // Y position in pixels
        width: 100              // Button width in pixels
        height: 50              // Button height in pixels
        onClicked: {            // Action when button is clicked
            stackView.pop()     // Go back to previous page in StackView (assumes this is part of a stack)
        }
        contentItem: Text {     // Text inside the button
            text: parent.text   // Use the button's text
            font.pixelSize: 20  // Font size in pixels
            color: "#151818"    // Dark gray text color
            horizontalAlignment: Text.AlignHCenter // Center text horizontally
            verticalAlignment: Text.AlignVCenter   // Center text vertically
        }
        background: Rectangle { // Button background
            color: "#f5f113"    // Yellow background color
            opacity: 0.6        // 60% opacity for transparency
            border.width: 2     // 2-pixel border
            border.color: "#151818" // Dark gray border color
        }
    }
}
