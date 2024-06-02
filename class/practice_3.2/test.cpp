#include <print>
#include <Helpers.hpp>
#include <UnitTests.hpp>

int main() {
    UnitTests testSuite;

    testSuite.addTest("Dummy_test1",
    [](){
        // Build:
        double value = 0.4;
    
        // Operate:
        auto result = dummyFunc(value);

        // Check:
        ASSERT_EQ(result, 0.4)
    });
    testSuite.addTest("Dummy_test2",
    [](){
        // Build:
        double value = 0.0;
    
        // Operate:
        auto result = dummyFunc(value);

        // Check:
        ASSERT_EQ(result, 0.0)
    });
    testSuite.addTest("Triangle_test1", 
    [](){
        Triangle tri(3.0, 4.0, 5.0);
        double result = tri.calculateArea();
        ASSERT_EQ(result, 6.0);
        return true;
    });

    testSuite.addTest("Triangle_invalidSides", 
    [](){
        try {
            Triangle tri(1.0, 2.0, 3.0); 
        } catch (const std::invalid_argument&) {
            return true; 
        }
        return false; 
    });

    testSuite.addTest("Triangle_negativeSides", 
    [](){
        try {
            Triangle tri(-1.0, 2.0, 2.0); 
        } catch (const std::invalid_argument&) {
            return true; 
        }
        return false; 
    });

    testSuite.addTest("RGBColor_generateMagicColor_test1", 
    [](){
        RGBColor color(100, 50, 25);
        RGBColor magicColor = color.generateMagicColor();
        ASSERT_EQ(magicColor.getR(), 49);
        ASSERT_EQ(magicColor.getG(), 98);
        ASSERT_EQ(magicColor.getB(), 25);
        return true;
    });

    testSuite.addTest("RGBColor_generateMagicColor_test2", 
    [](){
        RGBColor color(0, 0, 0);
        RGBColor magicColor = color.generateMagicColor();
        ASSERT_EQ(magicColor.getR(), 0); 
        ASSERT_EQ(magicColor.getG(), 0); 
        ASSERT_EQ(magicColor.getB(), 0);
        return true;
    });

    testSuite.addTest("RGBColor_generateMagicColor_test3", 
    [](){
        RGBColor color(255, 127, 255);
        RGBColor magicColor = color.generateMagicColor();
        ASSERT_EQ(magicColor.getR(), 126);
        ASSERT_EQ(magicColor.getG(), 252);
        ASSERT_EQ(magicColor.getB(), 255);
        return true;
    });

    testSuite.addTest("RGBColor_invalidValues", 
    [](){
        try {
            RGBColor color(256, 100, 100); 
        } catch (const std::invalid_argument&) {
            return true; 
        }
        return false; 
    });


    testSuite.run();
}
