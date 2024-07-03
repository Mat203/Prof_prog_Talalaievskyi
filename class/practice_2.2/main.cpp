#include <iostream>
#include <fstream>
#include <sstream>
#include <array>
#include <vector>
#include <string>
#include <optional>

using namespace std;

constexpr int WIDTH = 5;
constexpr int HEIGHT = 5;

struct Pixel {
    int r, g, b;

    bool operator==(const Pixel& other) const {
        return r == other.r && g == other.g && b == other.b;
    }

    bool IsValid() const {
        return (r >= 0 && r <= 255) && (g >= 0 && g <= 255) && (b >= 0 && b <= 255);
    }
};

using ImageRow = std::array<Pixel, WIDTH>;

class Image {
public:
    Image() : image{} {} 

    bool readImage(const string& filename, const string& outputFilename) {
        ifstream inFile(filename);
        ofstream outFile(outputFilename);
        if (!inFile) {
            cerr << "Unable to open input file." << endl;
            return false;
        }

        for (int iRow = 0; iRow < HEIGHT; ++iRow) {
            string line;
            if (!getline(inFile, line)) {
                cerr << "Unexpected end of file. Expected " << HEIGHT << " lines." << endl;
                return false;
            }

            if (auto row = readRow(line)) {
                image[iRow] = std::move(*row); 
            } else {
                cerr << "Error parsing row " << iRow + 1 << "." << endl;
                return false;
            }
        }

        if (inFile.fail()) {
            cerr << "Error reading input file." << endl;
            return false;
        }

        return true;
    }

    void writeImage(const string& filename) const {
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

    void applyFavoriteColor(const Pixel& favColor) {
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

private:
    std::array<ImageRow, HEIGHT> image; 
    std::optional<ImageRow> readRow(const std::string& line) {
        stringstream ss(line);
        ImageRow row;
        for (int col = 0; col < WIDTH; ++col) {
            Pixel pixel;
            char comma;
            if (!(ss >> pixel.r >> comma >> pixel.g >> comma >> pixel.b) || comma != ',') {
                return std::nullopt; 
            }
            if (!pixel.IsValid()) {
                return std::nullopt; 
            }
            row[col] = pixel;
        }
        return row; 
    }
};



int main() {
    string inputFilename, outputFilename;
    int favR, favG, favB;

    cout << "Enter input file name: ";
    cin >> inputFilename;
    cout << "Enter your favorite color (R G B): ";
    cin >> favR >> favG >> favB;

    Pixel favColor = { favR, favG, favB };
    if (!favColor.IsValid()) {
        cerr << "Favorite color values should be in the range 0-255." << endl;
        return 1;
    }

    cout << "Enter output file name: ";
    cin >> outputFilename;

    Image image;
    if (!image.readImage(inputFilename, outputFilename)) {
        return 1;
    }

    image.applyFavoriteColor(favColor);

    image.writeImage(outputFilename);

    cout << "Image processing completed. Check the output file: " << outputFilename << endl;

    return 0;
}