import Foundation

public struct MinesweeperBoardViewModel {
    public let board: BoardOutput
    
    public init(_ height: Int, _ width: Int) {
        let boardSetup = BoardGenerator.generateBoard(height, width)
        var minesweeper = Minesweeper(board: boardSetup)
        minesweeper.sweep()
        self.board = minesweeper.output
    }
}

enum BoardGenerator {
    static func generateBoard(_ height: Int, _ width: Int) -> BoardSetup {
        return BoardSetup(height: height, width: width, field: generateField(height, width))
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
