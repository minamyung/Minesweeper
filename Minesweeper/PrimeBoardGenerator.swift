import Foundation

struct PrimeBoardGenerator: BoardGenerator {
    let height: Int
    let width: Int
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
    }
    
    func generate() -> BoardSetup {
        return BoardSetup(height: height, width: width, field: PrimeBoardGenerator.generateField(height, width))
    }
    
    static func generateField(_ height: Int, _ width: Int) -> [[InputFieldState]] {
        var result = Array<Array<InputFieldState>>(
            repeating: Array<InputFieldState>(
                repeating: .empty,
                count: width),
            count: height)
        
        result.enumerated()
            .forEach { rowIndex, row in
                row.indices
                    .forEach { columnIndex in
                        if (rowIndex * width + columnIndex).isPrime {
                            result[rowIndex][columnIndex] = .mine
                        }
                    }
            }
        return result
    }
}

extension Int {
    var isPrime: Bool {
        self > 1 && !(2..<self).contains { self % $0 == 0 }
    }
}
