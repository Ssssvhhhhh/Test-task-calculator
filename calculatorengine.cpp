#include "calculatorengine.h"

#include <QDebug>
#include <QVector>
#include <QStack>

CalculatorEngine::CalculatorEngine() {}

void CalculatorEngine::appendDigit(int digit)
{
    m_expression += QString::number(digit);
    qDebug() << "[CalcEng]" <<m_expression;
}

void CalculatorEngine::appendOperator(const QString &op)
{
    m_expression += op;
    qDebug() << "[CalcEng]" <<m_expression;
}



void CalculatorEngine::clear()
{
    m_expression = "";
    result = 0;
}

QString CalculatorEngine::calculate()
{
    auto rpn = infixToRPN(m_expression);
    result = evalRPN(rpn);
    qDebug() << "[CalcEng]" <<  "RESULT =" << result;
    m_expression = QString::number(result);
    return QString::number(result);
}

QString CalculatorEngine::toPercentResult()
{
    result = result / 100.0;
    return QString::number(result);
    result = 0;
}

QString CalculatorEngine::changeArithmeticSign()
{
    result = -result;
    qDebug() << "[CalcEng]" <<  "RESULT =" << result;
    return QString::number(result);
}


int CalculatorEngine::precedence(const QChar &op)
{
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}

QVector<QString> CalculatorEngine::infixToRPN(const QString& expr)
{
    QVector<QString> out;
    QStack<QChar> ops;
    QString num;

    auto flushNum = [&]() {
        if (!num.isEmpty()) {
            out.push_back(num);
            num.clear();
        }
    };

    for (int i = 0; i < expr.size(); i++)
    {
        QChar c = expr[i];
        if (c.isSpace()) continue;

        if (c.isDigit() || c == '.' ||(c == '-' && (i == 0 || expr[i - 1] == '(' || precedence(expr[i - 1]) > 0)))
        {
            num += c;
        }
        else if (c == '(')
        {
            flushNum();
            ops.push(c);
        }
        else if (c == ')')
        {
            flushNum();
            while (!ops.isEmpty() && ops.top() != '(')
            {
                out.push_back(QString(ops.pop()));
            }
            if (!ops.isEmpty()) ops.pop();
        }
        else
        {
            flushNum();
            while (!ops.isEmpty() && precedence(ops.top()) >= precedence(c))
            {
                out.push_back(QString(ops.pop()));
            }
            ops.push(c);
        }
    }

    flushNum();
    while (!ops.isEmpty())
    {
        out.push_back(QString(ops.pop()));
    }

    return out;
}

double CalculatorEngine::evalRPN(const QVector<QString> &rpn)
{
    QStack<double> st;
    for (const auto& t : rpn)
    {
        if (t == "+" || t == "-" || t == "*" || t == "/")
        {
            if (st.size() < 2)
            {
                qWarning() << "Ошибка: недостаточно операндов для оператора" << t;
                return 0.0;
            }
            double b = st.pop();
            double a = st.pop();
            if (t == "+") st.push(a + b);
            else if (t == "-") st.push(a - b);
            else if (t == "*") st.push(a * b);
            else
            {
                if (b == 0.0) {
                    qWarning() << "Ошибка: деление на ноль";
                    return 0.0;
                }
                st.push(a / b);
            }
        }
        else
        {
            bool ok;
            double val = t.toDouble(&ok);
            if (!ok)
            {
                qWarning() << "Ошибка: не удалось преобразовать в число:" << t;
                return 0.0;
            }
            st.push(val);
        }
    }

    if (st.isEmpty())
    {
        qWarning() << "Ошибка: стек пуст в конце вычислений";
        return 0.0;
    }
    return st.top();
}
