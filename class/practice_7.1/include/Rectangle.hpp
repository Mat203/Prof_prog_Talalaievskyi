#pragma once

class Rectangle {
public:
    Rectangle(double width = 0.0, double height = 0.0);
    double getWidth() const;
    double getHeight() const;
    double getArea() const;
    double getBiggerSide() const;
    bool canBePlacedInside(const Rectangle& other) const;

private:
    double width;
    double height;
};
