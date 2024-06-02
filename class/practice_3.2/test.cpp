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
    testSuite.addTest("Triangle_test1", [](){
        Triangle tri(3.0, 4.0, 5.0);
        double result = tri.calculateArea();
        ASSERT_EQ(result, 6.0);
        return true;
    });

    testSuite.addTest("Triangle_invalidSides", [](){
        try {
            Triangle tri(1.0, 2.0, 3.0); 
        } catch (const std::invalid_argument&) {
            return true; 
        }
        return false; 
    });

    testSuite.addTest("Triangle_negativeSides", [](){
        try {
            Triangle tri(-1.0, 2.0, 2.0); 
        } catch (const std::invalid_argument&) {
            return true; 
        }
        return false; 
    });


    testSuite.run();
}
