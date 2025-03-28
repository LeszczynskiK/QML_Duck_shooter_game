#ifndef HUNTER_H
#define HUNTER_H

#include <QObject>
#include <QDebug>

class Hunter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int xPos READ xPos WRITE setXPos NOTIFY xPosChanged)
    Q_PROPERTY(int width READ width CONSTANT)
    Q_PROPERTY(int height READ height CONSTANT)

public:
    explicit Hunter(QObject *parent = nullptr);

    int xPos();
    void setXPos(int x);

    int width(); //Width return
    int height(); //Height return

public slots:
    void moveLeft(); // Move object left
    void moveRight(); // Move object sight
    void shoot(); // Trigger shooting a bullet

signals:
    void xPosChanged(); // If pos changed
    void shotFired(int x, int y); // Signal to QML when a shot is fired with starting position

private:
    int m_xPos;    // X position of the hunter
    int m_width;  // Width of the hunter sprite
    int m_height; // Height of the hunter sprite
};

#endif // HUNTER_H
