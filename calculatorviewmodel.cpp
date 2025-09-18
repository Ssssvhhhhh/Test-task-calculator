#include "calculatorviewmodel.h"
#include <QDebug>
#include <QStack>
#include <QString>


CalculatorViewModel::CalculatorViewModel(QObject *parent)
    : QObject(parent)
{
}

void CalculatorViewModel::changeArithmeticSign()
{
    m_result = m_engine.changeArithmeticSign();
    emit resultChanged();

}

void CalculatorViewModel::toPercent()
{
    m_result =  m_engine.toPercentResult();
    emit resultChanged();
}

void CalculatorViewModel::appendSymbol(const QString &symbol)
{
    m_expression += symbol;
    if(symbol[0].isDigit())
    {
        m_engine.appendDigit(symbol.toInt());
    }
    else
    {
        m_engine.appendOperator(symbol);
    }
    emit symbolAppended(symbol);
    emit expressionChanged();
}

void CalculatorViewModel::appendParentheses()
{

    if(parenthesesCounter == 0)
    {
        m_expression += '(';
        parenthesesCounter++;
        m_engine.appendOperator("(");
    }
    else
    {
        m_expression += ')';
        parenthesesCounter = 0;
        m_engine.appendOperator(")");
    }

    emit expressionChanged();

}

void CalculatorViewModel::calculate()
{
    m_result =  m_engine.calculate();
    emit resultChanged();
}

void CalculatorViewModel::clear()
{
    m_engine.clear();
    m_result = "";
    m_expression = "";
    emit resultChanged();
    emit expressionChanged();

}

