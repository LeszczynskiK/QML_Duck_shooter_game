#include "game.h"

Game::Game(QObject *parent) : QObject(parent)
{

}

void Game::spawnDuck(int x, int type)
{
    // Create a new duck object with initial position (x, 0), type, and unique ID
    GameObject duck = {x, 0, type, false, nextId++}; // y=0 means it starts at the top of the screen
    objects.append(duck);                            // Add the duck to the list of active objects
    emit duckSpawned(duck.id, x, 0, type);           // Notify QML to visually spawn the duck
}

void Game::shootBullet(int x, int y)
{
    // Create a new bullet object with given position (x, y) and unique ID
    GameObject bullet = {x, y, 0, true, nextId++};   // type=0 is irrelevant for bullets
    objects.append(bullet);                          // Add the bullet to the list of active objects
    emit bulletSpawned(bullet.id, x, y);             // Notify QML to visually spawn the bullet
}

void Game::setScore(int score)
{
    // Update score only if it changes, then notify QML
    if (m_score != score) {
        m_score = score;
        emit scoreChanged();
    }
}

void Game::updateGame()
{
    // Loop through all objects to update their positions
    for (int i = 0; i < objects.size(); ++i) {
        if (objects[i].isBullet) {                   // If the object is a bullet
            objects[i].y -= 10;                      // Move bullet up by 10 pixels per update
            emit updatePosition(objects[i].id, objects[i].x, objects[i].y); // Tell QML to update bullet's position
            if (objects[i].y <= 0) {                 // If bullet goes off the top of the screen (y <= 0)
                emit objectDestroyed(objects[i].id); // Notify QML to remove the bullet
                objects.removeAt(i);                 // Remove bullet from the list
                --i;                                 // Adjust index after removal to avoid skipping objects
            }
        } else {                                     // If the object is a duck
            objects[i].y += 2;                       // Move duck down by 2 pixels per update
            emit updatePosition(objects[i].id, objects[i].x, objects[i].y); // Tell QML to update duck's position
            if (objects[i].y >= 700) {               // If duck reaches the bottom of the screen (700 px height)
                emit objectDestroyed(objects[i].id); // Notify QML to remove the duck
                objects.removeAt(i);                 // Remove duck from the list
                --i;                                 // Adjust index after removal
                emit gameOver();                     // Game is lost
                return;                             //Stop game actualisation
            }
        }
    }
    checkCollisions();                               // After moving objects, check for collisions
}

void Game::resetGame()
{
    // Clear all objects
    for (int i = 0; i < objects.size(); ++i) {
        emit objectDestroyed(objects[i].id); //Inform QML about objects deleting
    }
    objects.clear(); // Clear game object list
    nextId = 0;      // Reset identificators
    setScore(0);     // Reset score
}


// Collision detection mechanism with scoring:
// - Checks every bullet against every duck for overlap using a rectangular hitbox (80x80 px).
// - When a collision occurs, awards points based on duck type (type * 10), updates the score,
//   and removes both the duck and bullet from the game.
void Game::checkCollisions()
{
    for (int i = 0; i < objects.size(); ++i) {       // Outer loop: iterate over all objects to find bullets
        if (objects[i].isBullet) {                   // Only proceed if the current object is a bullet
            for (int j = 0; j < objects.size(); ++j) { // Inner loop: check against all objects to find ducks
                if (!objects[j].isBullet) {          // Only proceed if the current object is a duck
                    int dx = qAbs(objects[i].x - objects[j].x); // Calculate absolute difference in x positions
                    int dy = qAbs(objects[i].y - objects[j].y); // Calculate absolute difference in y positions
                    if (dx < 80 && dy < 80) {        // If both differences are less than 80 px, it's a collision
                        // Calculate points based on duck type (e.g., type 1 = 10, type 2 = 20, type 3 = 30)
                        int points = objects[j].type * 10;
                        setScore(m_score + points);  // Add points to the score and notify QML
                        emit objectDestroyed(objects[j].id); // Notify QML to destroy the duck
                        emit objectDestroyed(objects[i].id); // Notify QML to destroy the bullet
                        objects.removeAt(j);         // Remove duck from the list first
                        if (j < i) --i;              // Adjust outer index if duck was before bullet in list
                        objects.removeAt(i);         // Remove bullet from the list
                        --i;                         // Adjust outer index after removal
                        break;                       // Bullet can only hit one duck, so exit inner loop
                    }
                }
            }
        }
    }
}
