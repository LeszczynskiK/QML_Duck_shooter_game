#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QList>

class Game : public QObject
{
    Q_OBJECT    // Macro enabling Qt's meta-object compiler (moc) for signals and slots
    // Property for score, readable and writable from QML
    Q_PROPERTY(int score READ score WRITE setScore NOTIFY scoreChanged)
public:
    Game(QObject *parent = nullptr);

    // Struct to represent a game object (either a duck or a bullet)
    struct GameObject {
        int x;         // X-coordinate of the object in the game world (pixels)
        int y;         // Y-coordinate of the object in the game world (pixels)
        int type;      // Type of duck (1, 2, or 3) for scoring or visuals; ignored for bullets
        bool isBullet; // Flag to distinguish bullets (true) from ducks (false)
        int id;        // Unique identifier for each object to track it across C++ and QML
    };

    // Public methods callable from QML (Q_INVOKABLE makes them accessible)
    Q_INVOKABLE void spawnDuck(int x, int type); // Spawns a duck at given x position with specified type
    Q_INVOKABLE void shootBullet(int x, int y);  // Spawns a bullet at given x, y position
    Q_INVOKABLE void updateGame();               // Updates the game state (moves objects, checks collisions)
    Q_INVOKABLE void resetGame();                // Reset values from last game(after game lost)

    // Score getter and setter
    int score() const { return m_score; }        // Returns current score
    void setScore(int score);                    // Sets new score and notifies QML

signals:    // Signals emitted to communicate with QML
    void duckSpawned(int id, int x, int y, int type);    // Tells QML to create a duck with given ID, position, and type
    void bulletSpawned(int id, int x, int y);            // Tells QML to create a bullet with given ID and position
    void updatePosition(int id, int x, int y);           // Updates position of an object (duck or bullet) in QML
    void objectDestroyed(int id);                        // Tells QML to destroy an object with given ID
    void scoreChanged();                                 // Notifies QML when score changes
    void gameOver();                                    // Emit signal if duck will go behing screen...

private:
    QList<GameObject> objects; // List storing all active game objects (ducks and bullets)
    int nextId = 0;            // Counter for generating unique IDs for new objects
    int m_score = 0;           // Private member to store the player's score
    void checkCollisions();    // Private method to detect and handle collisions between bullets and ducks
};

#endif // GAME_H
