import Foundation

struct Pixel: Equatable {
    var r: Int
    var g: Int
    var b: Int
}

let WIDTH = 5
let HEIGHT = 5

func readImage(filename: String, outputFilename: String) -> [[Pixel]]? {
    guard let input = try? String(contentsOfFile: filename) else {
        print("Unable to open input file.")
        return nil
    }
    
    var image: [[Pixel]] = []
    let lines = input.components(separatedBy: .newlines)
    
    guard lines.count == HEIGHT else {
        print("Input file should contain exactly \(HEIGHT) lines.")
        try? "Input file should contain exactly \(HEIGHT) lines.".write(toFile: outputFilename, atomically: true, encoding: .utf8)
        return nil
    }

    for (row, line) in lines.enumerated() {
        let parts = line.components(separatedBy: " ")
        guard parts.count == WIDTH else {
            print("Input file should contain exactly \(WIDTH) pixels per line.")
            return nil
        }

        var pixelRow: [Pixel] = []
        for part in parts {
            let components = part.components(separatedBy: ",")
            guard components.count == 3,
                  let r = Int(components[0]),
                  let g = Int(components[1]),
                  let b = Int(components[2]),
                  (0...255).contains(r), (0...255).contains(g), (0...255).contains(b) else {
                print("Invalid input format at row \(row + 1).")
                return nil
            }
            pixelRow.append(Pixel(r: r, g: g, b: b))
        }
        image.append(pixelRow)
    }

    return image
}

func writeImage(filename: String, image: [[Pixel]]) {
    var output = ""
    for row in image {
        for (col, pixel) in row.enumerated() {
            output += "\(pixel.r),\(pixel.g),\(pixel.b)"
            if col < row.count - 1 {
                output += " "
            }
        }
        output += "\n"
    }
    
    do {
        try output.write(toFile: filename, atomically: true, encoding: .utf8)
    } catch {
        print("Unable to open output file.")
    }
}

func applyFavoriteColor(image: inout [[Pixel]], favColor: Pixel) {
    for row in 0..<HEIGHT {
        for col in 0..<WIDTH where image[row][col] == favColor {
            if col > 0 {
                image[row][col - 1] = favColor
            }
            if row > 0 {
                image[row - 1][col] = favColor
            }
        }
    }
}

func changeUnfavoriteColor(image: inout [[Pixel]], favColor: Pixel, unFavColor: Pixel) {
    for row in 0..<HEIGHT {
        for col in 0..<WIDTH where image[row][col] == unFavColor {
            image[row][col] = favColor
        }
    }
}

func getFilenameFromUser(prompt: String) -> String? {
    print(prompt, terminator: "")
    return readLine()
}

func getColorFromUser(prompt: String) -> Pixel? {
    print(prompt, terminator: "")
    guard let colorInput = readLine(),
          let r = Int(colorInput.components(separatedBy: " ")[0]),
          let g = Int(colorInput.components(separatedBy: " ")[1]),
          let b = Int(colorInput.components(separatedBy: " ")[2]),
          (0...255).contains(r), (0...255).contains(g), (0...255).contains(b) else {
        print("Invalid color input.")
        return nil
    }
    return Pixel(r: r, g: g, b: b)
}

func processImage(inputFilename: String, outputFilename: String, favColor: Pixel, unFavColor: Pixel?) {
    guard var image = readImage(filename: inputFilename, outputFilename: outputFilename) else {
        return 
    }

    applyFavoriteColor(image: &image, favColor: favColor)
    if let unFavColor = unFavColor {
        changeUnfavoriteColor(image: &image, favColor: favColor, unFavColor: unFavColor)
    }

    writeImage(filename: outputFilename, image: image)
    print("Image processing completed. Check the output file: \(outputFilename)")
}

func main() {
    guard let inputFilename = getFilenameFromUser(prompt: "Enter input file name: "),
          let favColor = getColorFromUser(prompt: "Enter your favorite color (R G B): "),
          let outputFilename = getFilenameFromUser(prompt: "Enter output file name: ") else {
        return
    }

    print("Do you want to enter an unfavorite color? (y/n): ", terminator: "")
    let answer = readLine()

    var unFavColor: Pixel?
    if answer == "y" || answer == "Y" {
        unFavColor = getColorFromUser(prompt: "Enter your unfavorite color (R G B): ")
    }

    processImage(inputFilename: inputFilename, outputFilename: outputFilename, favColor: favColor, unFavColor: unFavColor)
}

main()