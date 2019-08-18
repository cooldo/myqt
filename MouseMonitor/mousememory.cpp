#include "mousememory.h"
#include <QDebug>

MouseMemory::MouseMemory(QObject *parent) : QObject(parent)
{

}

void MouseMemory::test()
{
   qDebug() << "hello from cpp";

}

void MouseMemory::save()
{
   qDebug() << "save data";
}

void MouseMemory::add(int x, int y)
{
   QPoint p(x, y);
   qDebug() << "adding p"<< p;
}

void MouseMemory::add(QPointF point)
{
   qDebug() << "adding p"<<point;
}
