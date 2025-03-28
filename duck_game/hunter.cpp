#include "hunter.h"

Hunter::Hunter(QObject *parent)
    : QObject(parent), m_xPos(300), m_width(100), m_height(100) // Initial position and size of object
{
    // Values are example ones(they fit berfectly to this project by stilisation)
}

int Hunter::xPos() // Actual x position of object(we are only moving on x axis)
{
    return m_xPos;
}

void Hunter::setXPos(int x)
{
    if (x >= 50 && x <= 1170 && x != m_xPos) { // Limit movement within screen (assuming 1280px width) - 50px border
        m_xPos = x; // Set object position to x value
        emit xPosChanged(); // Emit singal about pos change
    }
}

int Hunter::width()
{
    return m_width;
}

int Hunter::height()
{
    return m_height;
}

void Hunter::moveLeft()
{
    setXPos(m_xPos - 10); // Move 10px left
}

void Hunter::moveRight()
{
    setXPos(m_xPos + 10); // Move 10px right
}

void Hunter::shoot()
{
    // Calculate bullet starting position (center of hunter)
    int bulletX = m_xPos + (m_width / 2) - 10; // Center of hunter, adjusted for bullet radius (20px diameter)
    int bulletY = 700 - m_height; // Start at the top of the hunter (700 - 100 = 600)
    emit shotFired(bulletX, bulletY); // Emit signal to QML with bullet starting coordinates
}
