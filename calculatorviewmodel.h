#ifndef CALCULATORVIEWMODEL_H
#define CALCULATORVIEWMODEL_H

#include <QObject>
#include <QVector>

#include "calculatorengine.h"

class CalculatorViewModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString expression READ expression NOTIFY expressionChanged)
    Q_PROPERTY(QString result READ result NOTIFY resultChanged)


public:
    explicit CalculatorViewModel(QObject *parent = nullptr);

    QString expression() const { return m_expression; }
    QString result() const { return m_result; }


    Q_INVOKABLE void changeArithmeticSign();

    Q_INVOKABLE void toPercent();
    Q_INVOKABLE void appendSymbol(const QString& symbol);
    Q_INVOKABLE void appendParentheses();
    Q_INVOKABLE void calculate();
    Q_INVOKABLE void clear();


signals:
    void expressionChanged();
    void resultChanged();
    void symbolAppended(QString symbol);


private:
    QString m_expression = "";
    QString m_result = "";
    CalculatorEngine m_engine;

    int parenthesesCounter = 0;
};

#endif // CALCULATORVIEWMODEL_H
