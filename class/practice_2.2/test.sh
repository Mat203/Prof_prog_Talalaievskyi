#!/bin/bash

run_test() {
    local input_file="$1"
    local fav_color="$2"
    local output_file="$3"
    local expected_output="$4"

    ./main <<EOF
$input_file
$fav_color
$output_file
EOF

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

# Test Case 1: Pixels scattered with the favorite color at various positions
fav_color="192 168 1"
cat > "$input_file" <<EOF
0,0,0 0,0,0 0,255,0 100,100,100 255,0,0
0,0,0 255,0,0 0,255,0 0,0,255 255,0,0
255,0,0 0,255,0 192,168,1 255,0,0 255,0,0
0,255,0 255,0,0 0,255,0 255,0,0 0,0,255
100,100,100 255,0,0 0,255,0 192,168,1 255,0,0
EOF
expected_output="0,0,0 0,0,0 0,255,0 100,100,100 255,0,0
0,0,0 255,0,0 192,168,1 0,0,255 255,0,0
255,0,0 192,168,1 192,168,1 255,0,0 255,0,0
0,255,0 255,0,0 0,255,0 192,168,1 0,0,255
100,100,100 255,0,0 192,168,1 192,168,1 255,0,0"
run_test "$input_file" "$fav_color" "$output_file" "$expected_output"

# Test Case 2: No Favorite Color in Image
fav_color="192 168 1"
cat > "$input_file" <<EOF
0,0,0 0,0,0 0,255,0 100,100,100 255,0,0
0,0,0 255,0,0 0,255,0 0,0,255 255,0,0
255,0,0 0,255,0 100,100,100 255,0,0 255,0,0
0,255,0 255,0,0 0,255,0 255,0,0 0,0,255
100,100,100 255,0,0 0,255,0 100,100,100 255,0,0
EOF
expected_output="0,0,0 0,0,0 0,255,0 100,100,100 255,0,0
0,0,0 255,0,0 0,255,0 0,0,255 255,0,0
255,0,0 0,255,0 100,100,100 255,0,0 255,0,0
0,255,0 255,0,0 0,255,0 255,0,0 0,0,255
100,100,100 255,0,0 0,255,0 100,100,100 255,0,0"
run_test "$input_file" "$fav_color" "$output_file" "$expected_output"

# Test Case 3: All Pixels Are Favorite Color
fav_color="192 168 1"
cat > "$input_file" <<EOF
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
EOF
expected_output="192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1
192,168,1 192,168,1 192,168,1 192,168,1 192,168,1"
run_test "$input_file" "$fav_color" "$output_file" "$expected_output"

# Test Case 4: Favorite Color at Specific Pattern (Diagonal)
fav_color="192 168 1"
cat > "$input_file" <<EOF
0,0,0 0,0,0 0,0,0 0,0,0 0,0,0
0,0,0 192,168,1 0,0,0 0,0,0 0,0,0
0,0,0 0,0,0 192,168,1 0,0,0 0,0,0
0,0,0 0,0,0 0,0,0 192,168,1 0,0,0
0,0,0 0,0,0 0,0,0 0,0,0 192,168,1
EOF
expected_output="0,0,0 192,168,1 0,0,0 0,0,0 0,0,0
192,168,1 192,168,1 192,168,1 0,0,0 0,0,0
0,0,0 192,168,1 192,168,1 192,168,1 0,0,0
0,0,0 0,0,0 192,168,1 192,168,1 192,168,1
0,0,0 0,0,0 0,0,0 192,168,1 192,168,1"
run_test "$input_file" "$fav_color" "$output_file" "$expected_output"

# Test Case 5: Number of Lines Less Than Expected
fav_color="192 168 1"
cat > "$input_file" <<EOF
0,0,0 0,0,0 0,0,0 0,0,0 0,0,0
0,0,0 192,168,1 0,0,0 0,0,0 0,0,0
0,0,0 0,0,0 192,168,1 0,0,0 0,0,0
0,0,0 0,0,0 0,0,0 192,168,1 0,0,0
EOF
expected_output="Input file should contain exactly 5 lines."
run_test "$input_file" "$fav_color" "$output_file" "$expected_output"


exit $?
