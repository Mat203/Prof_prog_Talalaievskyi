#!/bin/bash

# Define input and output files for the test cases
input_file_1="input1.txt"
input_file_2="input2.txt"
input_file_3="input3.txt"
input_file_4="input4.txt"
input_file_5="input5.txt"
exptected_output="output.txt"
output_file_1="output1.txt"
output_file_2="output2.txt"
output_file_3="output3.txt"
output_file_4="output4.txt"
output_file_5="output5.txt"

# Define the favorite color for the test cases
fav_color="192 168 1"

# Compile the C++ program
g++ -o main main.cpp

# Function to execute the program with the given input and check the result
test_case() {
    local input_file="$1"
    local output_file="$2"
    local expected_output_file="$3"

    # Execute the program with the test case input
    ./main <<EOF
$input_file
$fav_color
$output_file
EOF

    # Check if the output file has been created
    if [ -f "$output_file" ]; then
        echo "Output file generated successfully for $input_file."

        # Check if the output is as expected
        if diff "$output_file" "$expected_output_file" > /dev/null; then
            echo "Test case passed: Output matches the expected result for $input_file."
        else
            echo "Test case failed: Output does not match the expected result for $input_file."
            echo "Expected output: $(cat "$expected_output_file")"
            echo "Actual output: $(cat "$output_file")"
        fi
    else
        echo "Failed to generate the output file for $input_file."
    fi
}

# Test case 1: Pixels without any occurrence of the favorite color
test_case "$input_file_1" "$exptected_output" "$input_file_1"

# Test case 2: All pixels set to the favorite color
test_case "$input_file_2" "$exptected_output" "$input_file_2"

# Test case 3: Pixels forming a specific pattern with the favorite color (diagonal)
test_case "$input_file_3" "$exptected_output" "$output_file_3"

# Test case 4: All pixels set to the favorite color
test_case "$input_file_4" "$exptected_output" "$input_file_4"

# Test case 5: Fewer lines in the input file than expected (This case should cause an error)
test_case "$input_file_5" "$exptected_output" "$output_file_5"
