#include <print>
#include <UnitTests.hpp>
#include <Rectangle.hpp>
#include <RectangleManager.hpp>

int main() {
UnitTests testSuite;

    testSuite.addTest("Rectangle_getters",
    []() {
        Rectangle rect(3, 4);
    
        ASSERT_EQ(rect.getWidth(), 3);
        ASSERT_EQ(rect.getHeight(), 4);
        ASSERT_EQ(rect.getArea(), 12);
        ASSERT_EQ(rect.getBiggerSide(), 4);
    });

    testSuite.addTest("Rectangle_placement",
    []() {
        Rectangle rect1(3, 4);
        Rectangle rect2(5, 6);
        Rectangle rect3(2, 3);
    
        ASSERT_EQ(rect1.canBePlacedInside(rect2), true);
        ASSERT_EQ(rect1.canBePlacedInside(rect3), false);
        ASSERT_EQ(rect3.canBePlacedInside(rect1), true);
    });

    testSuite.addTest("RectangleManager_biggestArea",
    []() {
        RectangleManager manager;
        manager.addRectangle(Rectangle(3, 4));
        manager.addRectangle(Rectangle(5, 6));
        manager.addRectangle(Rectangle(2, 3));
        manager.addRectangle(Rectangle(4, 5));
        manager.addRectangle(Rectangle(1, 2));
    
        ASSERT_EQ(manager.getBiggestArea(), 30);
    });

    testSuite.addTest("RectangleManager_smallestArea",
    []() {
        RectangleManager manager;
        manager.addRectangle(Rectangle(3, 4));
        manager.addRectangle(Rectangle(5, 6));
        manager.addRectangle(Rectangle(2, 3));
        manager.addRectangle(Rectangle(4, 5));
        manager.addRectangle(Rectangle(1, 2));
    
        ASSERT_EQ(manager.getSmallestArea(), 2);
    });

    testSuite.addTest("RectangleManager_totalArea",
    []() {
        RectangleManager manager;
        manager.addRectangle(Rectangle(3, 4));
        manager.addRectangle(Rectangle(5, 6));
        manager.addRectangle(Rectangle(2, 3));
        manager.addRectangle(Rectangle(4, 5));
        manager.addRectangle(Rectangle(1, 2));
    
        ASSERT_EQ(manager.getTotalArea(), 70);
    });

    testSuite.run();
}
