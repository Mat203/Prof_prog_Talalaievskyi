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
    testSuite.addTest("Dummy_test3",
    [](){
        // Build:
        double value = -0.3;
    
        // Operate:
        auto result = dummyFunc(value);

        // Check:
        ASSERT_EQ(result, 0)
    });

    testSuite.addTest("repeatString_test1",
    [](){
        // Build:
        std::vector<int> numbers = {0, 2, 1};
        std::string str = "home";

        // Operate:
        auto result = repeatString(numbers, str);

        // Check:
        ASSERT_EQ(result, "homehome"); 
    });
    testSuite.addTest("repeatString_test2",
    [](){
        // Build:
        std::vector<int> numbers = {1, 5, 3};
        std::string str = "hello";

        // Operate:
        auto result = repeatString(numbers, str);

        // Check:
        ASSERT_EQ(result, "hellohellohellohellohello"); 
    });
    testSuite.addTest("repeatString_test3",
    [](){
        // Build:
        std::vector<int> numbers = {}; // Empty vector
        std::string str = "world";

        // Operate:
        auto result = repeatString(numbers, str);

        // Check:
        ASSERT_EQ(result, ""); 
    });
    testSuite.addTest("repeatString_test4",
    [](){
        // Build:
        std::vector<int> numbers = {-5, 2, 0};
        std::string str = "negative";

        // Operate:
        auto result = repeatString(numbers, str);

        // Check:
        ASSERT_EQ(result, "negativenegative"); 
    });
    testSuite.addTest("repeatString_test5",
    [](){
        // Build:
        std::vector<int> numbers = {-2, -1, -3};
        std::string str = "all_negative";

        // Operate:
        auto result = repeatString(numbers, str);

        // Check:
        ASSERT_EQ(result, ""); 
    });


    testSuite.run();
}
