#include <print>
#include "Helpers.hpp"
#include "UnitTests.hpp" 

int main() {
    UnitTests testSuite;

    testSuite.addTest("AcquireRelease_Normal", []() {
        MegaDataPool pool(3);
        MegaData& obj1 = pool.acquire();
        pool.release(obj1);
        ASSERT_EQ(pool.usedSize(), 0); 
    });

    testSuite.addTest("Acquire_PoolFull", []() {
        MegaDataPool pool(2);
        pool.acquire(); 
        pool.acquire(); 
        ASSERT_EQ(pool.usedSize(), 2);
        bool exceptionThrown = false;
        try {
            pool.acquire(); 
        } catch (const std::runtime_error& e) {
            exceptionThrown = true;
        }
        ASSERT_EQ(exceptionThrown, true); 
    });

    testSuite.addTest("Release_TooMany", []() {
        MegaDataPool pool(2);
        MegaData& obj1 = pool.acquire();
        pool.release(obj1);
        bool exceptionThrown = false;
        try {
            pool.release(obj1); 
        } catch (const std::runtime_error& e) {
            exceptionThrown = true;
        }
        ASSERT_EQ(exceptionThrown, true);
    });

    testSuite.addTest("DataPersistence_AfterRelease", []() {
        MegaDataPool pool(1);
        MegaData& obj1 = pool.acquire();
        obj1.getSmallArray()[0] = 12.34f; 
        pool.release(obj1);
        MegaData& obj2 = pool.acquire(); 
        ASSERT_EQ(obj2.getSmallArray()[0], 42.0f); 
    });

    testSuite.run();
    return 0;
}