import Foundation

struct Pixel: Equatable {
    var r: Int
    var g: Int
    var b: Int
}

class Image {
    static let width = 5
    static let height = 5
    var pixels: [[Pixel]]
    
    init(pixels: [[Pixel]]) {
        self.pixels = pixels
    }
    
    static func readInfo(filename: String, outputFilename: String) -> Image? {
        guard let input = try? String(contentsOfFile: filename) else {
            print("Unable to open input file.")
            return nil
        }
        
        var pixels: [[Pixel]] = []
        let lines = input.components(separatedBy: .newlines)
        
        guard lines.count == height else {
            print("Input file should contain exactly \(height) lines.")
            try? "Input file should contain exactly \(height) lines.".write(toFile: outputFilename, atomically: true, encoding: .utf8)
            return nil
        }

        for (row, line) in lines.enumerated() {
            let parts = line.components(separatedBy: " ")
            guard parts.count == width else {
                print("Input file should contain exactly \(width) pixels per line.")
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
            pixels.append(pixelRow)
        }

        return Image(pixels: pixels)
    }

    func writeInfo(filename: String) {
        var output = ""
        for row in pixels {
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

    func applyFavoriteColor(favColor: Pixel) {
        for row in 0..<Image.height {
            for col in 0..<Image.width where pixels[row][col] == favColor {
                if col > 0 {
                    pixels[row][col - 1] = favColor
                }
                if row > 0 {
                    pixels[row - 1][col] = favColor
                }
            }
        }
    }

    func changeUnfavoriteColor(favColor: Pixel, unFavColor: Pixel) {
        for row in 0..<Image.height {
            for col in 0..<Image.width where pixels[row][col] == unFavColor {
                pixels[row][col] = favColor
            }
        }
    }

    func processImage(outputFilename: String, favColor: Pixel, unFavColor: Pixel?) {
        applyFavoriteColor(favColor: favColor)
        if let unFavColor = unFavColor {
            changeUnfavoriteColor(favColor: favColor, unFavColor: unFavColor)
        }
        writeInfo(filename: outputFilename)
        print("Image processing completed. Check the output file: \(outputFilename)")
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

    if let image = Image.readInfo(filename: inputFilename, outputFilename: outputFilename) {
        image.processImage(outputFilename: outputFilename, favColor: favColor, unFavColor: unFavColor)
    }
}

main()