#ifndef CALCULATORENGINE_H
#define CALCULATORENGINE_H

#include <QString>


class CalculatorEngine
{
public:
    CalculatorEngine();
    void appendDigit(int  digit);
    void appendOperator(const QString& op);

    void clear();
    QString expression() const;
    QString calculate();
    QString toPercentResult();
    QString changeArithmeticSign();

    //RPN metods
    int precedence(const QChar& op);
    QVector<QString> infixToRPN (const QString& expr);
    double evalRPN(const QVector<QString>& rpn);
    //

private:
    QString m_expression;
    double result  = 0;

};

#endif // CALCULATORENGINE_H
