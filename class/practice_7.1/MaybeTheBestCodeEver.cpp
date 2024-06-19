#include <iostream>

int gCount = 0;
double gBiggestArea = 0;
double gSmallestArea = 1000000;

int main() {
    double width1 = 0.0, height1 = 0.0, width2 = 0.0, height2 = 0.0, width3 = 0.0, height3 = 0.0, width4 = 0.0, height4 = 0.0, width5 = 0.0, height5 = 0.0;

    std::cout << "Enter rectangle 1:" << std::endl;
    if (gCount < 5 && std::cin >> width1 >> height1) {
        double area1 = width1 * height1;
        gCount++;
        if (area1 > gBiggestArea) {
            gBiggestArea = area1;
        }

        std::cout << "Enter rectangle 2:" << std::endl;
        if (gCount < 5 && std::cin >> width2 >> height2) {
            double area2 = width2 * height2;
            gCount++;
            if (area2 > gBiggestArea) {
                gBiggestArea = area2;
            }

            std::cout << "Enter rectangle 3:" << std::endl;
            if (gCount < 5 && std::cin >> width3 >> height3) {
                double area3 = width3 * height3;
                gCount++;
                if (area3 > gBiggestArea) {
                    gBiggestArea = area3;
                }

                std::cout << "Enter rectangle 4:" << std::endl;
                if (gCount < 5 && std::cin >> width4 >> height4) {
                    double area4 = width4 * height4;
                    gCount++;
                    if (area4 > gBiggestArea) {
                        gBiggestArea = area4;
                    }

                    std::cout << "Enter rectangle 5:" << std::endl;
                    if (gCount < 5 && std::cin >> width5 >> height5) {
                        double area5 = width5 * height5;
                        gCount++;
                        if (area5 > gBiggestArea) {
                            gBiggestArea = area5;
                        }
                    }
                }
            }
        }
    }

    if (width1 <= width2 && height1 <= height2) {
        std::cout << "Rectangle 1 can be placed inside Rectangle 2" << std::endl;
    }

    if (width1 <= width3 && height1 <= height3) {
        std::cout << "Rectangle 1 can be placed inside Rectangle 3" << std::endl;
    }

    if (width1 <= width4 && height1 <= height4) {
        std::cout << "Rectangle 1 can be placed inside Rectangle 4" << std::endl;
    }

    if (width1 <= width5 && height1 <= height5) {
        std::cout << "Rectangle 1 can be placed inside Rectangle 5" << std::endl;
    }

    if (width2 <= width1 && height2 <= height1) {
        std::cout << "Rectangle 2 can be placed inside Rectangle 1" << std::endl;
    }

    if (width2 <= width3 && height2 <= height3) {
        std::cout << "Rectangle 2 can be placed inside Rectangle 3" << std::endl;
    }

    if (width2 <= width4 && height2 <= height4) {
        std::cout << "Rectangle 2 can be placed inside Rectangle 4" << std::endl;
    }

    if (width2 <= width5 && height2 <= height5) {
        std::cout << "Rectangle 2 can be placed inside Rectangle 5" << std::endl;
    }

    if (width3 <= width1 && height3 <= height1) {
        std::cout << "Rectangle 3 can be placed inside Rectangle 1" << std::endl;
    }

    if (width3 <= width2 && height3 <= height2) {
        std::cout << "Rectangle 3 can be placed inside Rectangle 2" << std::endl;
    }

    if (width3 <= width4 && height4 <= height3) {
        std::cout << "Rectangle 3 can be placed inside Rectangle 4" << std::endl;
    }

    if (width3 <= width5 && height3 <= height5) {
        std::cout << "Rectangle 3 can be placed inside Rectangle 5" << std::endl;
    }

    if (width4 <= width1 && height4 <= height1) {
        std::cout << "Rectangle 4 can be placed inside Rectangle 1" << std::endl;
    }

    if (width4 <= width2 && height4 <= height2) {
        std::cout << "Rectangle 4 can be placed inside Rectangle 2" << std::endl;
    }

    if (width4 <= width3 && height4 <= height3) {
        std::cout << "Rectangle 4 can be placed inside Rectangle 3" << std::endl;
    }

    if (width4 <= width5 && height4 <= height5) {
        std::cout << "Rectangle 4 can be placed inside Rectangle 5" << std::endl;
    }

    if (width5 <= width1 && height5 <= height1) {
        std::cout << "Rectangle 5 can be placed inside Rectangle 1" << std::endl;
    }

    if (width5 <= width2 && height5 <= height2) {
        std::cout << "Rectangle 5 can be placed inside Rectangle 2" << std::endl;
    }

    if (width5 <= width3 && height5 <= height3) {
        std::cout << "Rectangle 5 can be placed inside Rectangle 2" << std::endl;
    }

    if (width5 <= width4 && height5 <= height4) {
        std::cout << "Rectangle 5 can be placed inside Rectangle 4" << std::endl;
    }

    std::cout << "The biggest area: " << gBiggestArea << std::endl;
    std::cout << "Number of rectangles: " << gCount << std::endl;

    // Let's calculate the smallest area:
    gSmallestArea = width1 * height1;
    if (width2 * height2 < gSmallestArea) {
        gSmallestArea = width2 * height2;
    }
    if (width3 * height3 < gSmallestArea) {
        gSmallestArea = width3 * height3;
    }
    if (width4 * height4 < gSmallestArea) {
        gSmallestArea = width4 * height4;
    }
    if (width5 * height5 < gSmallestArea) {
        gSmallestArea = width5 * height5;
    }
    std::cout << "The smallest area: " << gSmallestArea << std::endl;

    // the bigger side of rectangle:
    double biggerSide = width1;
    if (height1 > biggerSide) {
        biggerSide = height1;
    }
    std::cout << "The biggest side of rectangle 1:" << biggerSide << std::endl;

    biggerSide = width2;
    if (height2 > biggerSide) {
        biggerSide = height2;
    }
    std::cout << "The biggest side of rectangle 2:" << biggerSide << std::endl;

    biggerSide = width3;
    if (height3 > biggerSide) {
        biggerSide = height3;
    }
    std::cout << "The biggest side of rectangle 3:" << biggerSide << std::endl;

    biggerSide = width4;
    if (height4 > biggerSide) {
        biggerSide = height4;
    }
    std::cout << "The biggest side of rectangle 4:" << biggerSide << std::endl;

    biggerSide = width5;
    if (height5 > biggerSide) {
        biggerSide = height5;
    }
    std::cout << "The biggest side of rectangle 5:" << biggerSide << std::endl;

    // Total area of rectangles:
    std::cout << "Total area of rectangles: " << (width1 * height1 + width2 * height2 + width3 * height3 + width4 * height4 + width5 * height5) << std::endl;

    return 0;
}
