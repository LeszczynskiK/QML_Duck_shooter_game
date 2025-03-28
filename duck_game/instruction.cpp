#include "instruction.h"

// Constructor
Instruction::Instruction(QObject *parent) : QObject(parent) {}

// Function to return the game instructions
QString Instruction::getInstructions() const
{
    return instructions;
}
