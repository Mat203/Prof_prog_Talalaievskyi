#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>

using namespace std;

struct Pixel {
    int r, g, b;

    bool operator==(const Pixel& other) const {
        return r == other.r && g == other.g && b == other.b;
    }
};

const int WIDTH = 5;
const int HEIGHT = 5;

bool readImage(const string& filename, vector<vector<Pixel>>& image, const string& outputFilename) {
    ifstream inFile(filename);
    ofstream outFile(outputFilename);
    if (!inFile) {
        cerr << "Unable to open input file." << endl;
        return false;
    }

    string line;
    int row = 0;
    while (getline(inFile, line)) {
        stringstream ss(line);
        vector<Pixel> pixelRow;
        for (int col = 0; col < WIDTH; ++col) {
            Pixel pixel;
            char comma;
            ss >> pixel.r >> comma >> pixel.g >> comma >> pixel.b;
            if (comma != ',' || pixel.r < 0 || pixel.r > 255 || pixel.g < 0 || pixel.g > 255 || pixel.b < 0 || pixel.b > 255) {
                cerr << "Invalid input format at row " << row + 1 << ", column " << col + 1 << "." << endl;
                return false;
            }
            pixelRow.push_back(pixel);
        }
        if (pixelRow.size() != WIDTH) {
            cerr << "Input file should contain exactly " << WIDTH << " pixels per line." << endl;
            return false;
        }
        image.push_back(pixelRow);
        ++row;
    }

    if (row != HEIGHT || image.size() != HEIGHT) {
        cerr << "Input file should contain exactly " << HEIGHT << " lines." << endl;
        if (outFile) {
            outFile << "Input file should contain exactly " << HEIGHT << " lines.";
        }
        return false;
    }

    return true;
}


void writeImage(const string& filename, const vector<vector<Pixel>>& image) {
    ofstream outFile(filename);
    if (!outFile) {
        cerr << "Unable to open output file." << endl;
        return;
    }

    for (const auto& row : image) {
        for (size_t col = 0; col < row.size(); ++col) {
            outFile << row[col].r << ',' << row[col].g << ',' << row[col].b;
            if (col < row.size() - 1) {
                outFile << ' ';
            }
        }
        outFile << '\n';
    }
}

void applyFavoriteColor(vector<vector<Pixel>>& image, const Pixel& favColor) {
    for (int row = 0; row < HEIGHT; ++row) {
        for (int col = 0; col < WIDTH; ++col) {
            if (image[row][col] == favColor) {
                if (col > 0) { 
                    image[row][col - 1] = favColor;
                }
                if (row > 0) { 
                    image[row - 1][col] = favColor;
                }
            }
        }
    }
}

int main() {
    string inputFilename, outputFilename;
    int favR, favG, favB;

    cout << "Enter input file name: ";
    cin >> inputFilename;
    cout << "Enter your favorite color (R G B): ";
    cin >> favR >> favG >> favB;
    cout << "Enter output file name: ";
    cin >> outputFilename;

    if (favR < 0 || favR > 255 || favG < 0 || favG > 255 || favB < 0 || favB > 255) {
        cerr << "Favorite color values should be in the range 0-255." << endl;
        return 1;
    }

    Pixel favColor = { favR, favG, favB };

    vector<vector<Pixel>> image;
    if (!readImage(inputFilename, image, outputFilename)) {
    return 1;
    }

    applyFavoriteColor(image, favColor);

    writeImage(outputFilename, image);

    cout << "Image processing completed. Check the output file: " << outputFilename << endl;

    return 0;
}
