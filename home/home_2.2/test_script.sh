#!/bin/bash

swiftc main.swift -o main

# Define input and output files for the test cases
input_file_1="input1.txt"
input_file_2="input2.txt"
input_file_3="input3.txt"
input_file_4="input4.txt"
input_file_5="input5.txt"
input_file_6="input6.txt"
exptected_output="output.txt"
output_file_1="output1.txt"
output_file_2="output2.txt"
output_file_3="output3.txt"
output_file_4="output4.txt"
output_file_5="output5.txt"
output_file_6="output6.txt"

run_test() {
    local input_file="$1"
    local fav_color="$2"
    local unfav_choice="$4" 
    local output_file="$3"
    local expected_output="$5"
    local unfav_color="$6"

    if [ "$unfav_choice" == "y" ]; then
        printf "%s\n%s\n%s\n%s\n%s\n" "$input_file" "$fav_color" "$output_file" "$unfav_choice" "$unfav_color" | ./main
    else
        printf "%s\n%s\n%s\n%s\n" "$input_file" "$fav_color" "$output_file" "$unfav_choice" | ./main
    fi

    if [ -f "$output_file" ]; then
        echo "Output file generated successfully for $input_file."

        actual_output=$(cat "$output_file")

        if [ "$actual_output" == "$expected_output" ]; then
            echo "Test case passed: Output matches expected result."
        else
            echo "Test case failed: Output does not match the expected result."
            echo "Expected output:"
            echo "$expected_output"
            echo "Actual output:"
            echo "$actual_output"
            return 1
        fi
    else
        echo "Failed to generate the output file: $output_file"
        return 1
    fi

    return 0
}

input_file="input.txt"
output_file="output.txt"
no_choice="n"
y_choice="y"
unfav_color="100 100 100" 

# Test Case 1: Pixels scattered with the favorite color at various positions
fav_color="192 168 1"
run_test "$input_file_1" "$fav_color" "$output_file" "$no_choice" "$output_file_1"

# Test Case 2: No Favorite Color in Image
fav_color="192 168 1"
run_test "$input_file_2" "$fav_color" "$output_file" "$no_choice" "$output_file_2"

# Test Case 3: All Pixels Are Favorite Color
fav_color="192 168 1"
run_test "$input_file_3" "$fav_color" "$output_file" "$no_choice" "$output_file_3"

# Test Case 4: Favorite Color at Specific Pattern (Diagonal)
fav_color="192 168 1"
run_test "$input_file_4" "$fav_color" "$output_file" "$no_choice" "$output_file_4"

# Test Case 5: Number of Lines Less Than Expected
fav_color="192 168 1"
run_test "$input_file_5" "$fav_color" "$output_file" "$no_choice" "$output_file_5"

# Test Case 6: Using Unfavorable Color
fav_color="192 168 1"
unfav_color="100 100 100" 
run_test "$input_file_6" "$fav_color" "$output_file" "$y_choice" "$output_file_6" "$unfav_color"
exit $?
