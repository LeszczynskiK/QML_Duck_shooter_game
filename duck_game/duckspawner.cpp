#include "duckspawner.h"

DuckSpawner::DuckSpawner(QObject *parent)
    : QObject(parent)
{
    spawnTimer = new QTimer(this);
    connect(spawnTimer, &QTimer::timeout, this, &DuckSpawner::spawn);
}

void DuckSpawner::startSpawning()
{
    // Spawn ducks every 1-7 seconds
    spawnTimer->start(QRandomGenerator::global()->bounded(1000, 7000));
}

void DuckSpawner::spawn()
{
    // Random x position between 50 and 1170 (matching hunter movement limits)
    int x = QRandomGenerator::global()->bounded(50, 1171);

    // Random duck type (1, 2, or 3)
    int type = QRandomGenerator::global()->bounded(1, 4);
    emit spawnDuck(x, type); // Emit signal to QML

    // Restart timer with a new random interval (1-7 seconds)
    spawnTimer->start(QRandomGenerator::global()->bounded(1000, 7000));
}
