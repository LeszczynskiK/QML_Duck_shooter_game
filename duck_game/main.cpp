#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>//To manate ContextProperty

#include "game.h"
#include "instruction.h"
#include "hunter.h"
#include "duckspawner.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Register Instruction with QML
    Instruction instruction;
    engine.rootContext()->setContextProperty("instructionObject", &instruction);

    // Register Hunter with QML
    Hunter hunter;
    engine.rootContext()->setContextProperty("hunterObject", &hunter);

    // Register DuckSpawner with QML
    DuckSpawner duckSpawner;
    engine.rootContext()->setContextProperty("duckSpawner", &duckSpawner);

    // Register Game with QML
    Game game;
    engine.rootContext()->setContextProperty("gameObject", &game);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("duck_game", "Main");

    // Start spawning ducks after the engine is loaded
    duckSpawner.startSpawning();

    return app.exec();
}
