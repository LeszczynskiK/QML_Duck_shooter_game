#ifndef DUCKSPAWNER_H
#define DUCKSPAWNER_H

#include <QObject>
#include <QTimer>
#include <QRandomGenerator>

class DuckSpawner : public QObject
{
    Q_OBJECT
public:
    explicit DuckSpawner(QObject *parent = nullptr);

    void startSpawning(); // Start the spawning timer

signals:
    void spawnDuck(int x, int type); // Signal to spawn a duck at x position with a specific type

private slots:
    void spawn(); // Slot to handle spawning a duck

private:
    QTimer *spawnTimer; // Timer to spawn ducks at random intervals
};

#endif // DUCKSPAWNER_H
