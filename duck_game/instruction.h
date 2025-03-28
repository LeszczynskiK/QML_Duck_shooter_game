#ifndef INSTRUCTION_H
#define INSTRUCTION_H

#include <QObject>

class Instruction : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString gameInstructions READ getInstructions NOTIFY instructionsChanged)

public:
    explicit Instruction(QObject *parent = nullptr);

    // Function that returns the game instructions
    QString getInstructions() const;

signals:
    void instructionsChanged();

private:
    // Game instructions text
    QString instructions = "How to Play:\n\n"
                           "- Ducks will appear at the top of the screen and fall down.\n"
                           "- There are three types of ducks, each with different point values.\n"
                           "- Move the hunter block using 'A' and 'D' or arrow keys.\n"
                           "- Shoot ducks by pressing the space button.\n"
                           "- The game ends if a duck reaches the bottom of the screen.\n"
                           "- Try to achieve the highest score!";
};

#endif // INSTRUCTION_H
