#!/bin/bash

check_file_content() {
    local expected_content="$1"
    local file_content

    if [[ -f "user_stats.txt" ]]; then
        file_content=$(cat user_stats.txt)
        if diff <(echo "$file_content") <(echo -e "$expected_content"); then
            echo "Test Passed: File content is correct."
        else
            echo "Test Failed: File content is incorrect."
            echo "Expected: $expected_content"
            echo "Got: $file_content"
            exit 1
        fi
    else
        echo "Test Failed: File 'user_stats.txt' does not exist."
        exit 1
    fi
}

clang++ -std=c++23 -Wall HelloWorld.cpp -o main

run_test_case() {
    local name=$1
    local commands=$2
    local expected_output=$3

    echo -n "" > user_stats.txt  

    echo -e "$commands" | ./main

    check_file_content "$expected_output"

    echo "Test case '$name' passed."
}

run_test_case "Test Case 1" "Alice\nexit\n" "Alice 1"

run_test_case "Test Case 2" "Vova\nFrank\nexit\n" "Frank 1\nVova 1"

run_test_case "Test Case 3" "Matilda\nMatilda\nexit\n" "Matilda 2"

run_test_case "Test Case 4" "Dazdraperma\nDazdraperma wtfsdf\n\nexit\n" "Dazdraperma 1"

run_test_case "Test Case 5" "Traktorina\nTraktorina delete\nexit\n" ""

run_test_case "Test Case 6" "Pyatvchet\nKima\nbread\nexit\n" ""

echo "All test cases passed."
