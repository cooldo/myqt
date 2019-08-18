#ifndef MOUSEMEMORY_H
#define MOUSEMEMORY_H

#include <QObject>
#include <QPoint>

class MouseMemory : public QObject
{
    Q_OBJECT
public:
    explicit MouseMemory(QObject *parent = nullptr);

    Q_INVOKABLE void test();
    Q_INVOKABLE void save();
    Q_INVOKABLE void add(int x, int y);
    Q_INVOKABLE void add(QPointF point);

signals:

public slots:
};

#endif // MOUSEMEMORY_H
