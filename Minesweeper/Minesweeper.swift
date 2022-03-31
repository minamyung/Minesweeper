public struct Minesweeper {
    let board: BoardSetup
    public var output: BoardOutput
    
    public init(board: BoardSetup) {
        self.board = board
        self.output = BoardOutput.new(width: board.width, height: board.height)
    }
    
    public mutating func sweep() {
        for rowIndex in board.field.indices {
            for columnIndex in board.field[rowIndex].indices {
                sweepCell(rowIndex, columnIndex)
            }
        }
    }
    
    private mutating func sweepCell(_ rowIndex: Int, _ columnIndex: Int) {
        let cellState = board.field[rowIndex][columnIndex]
        if cellState == .mine {
            output.field[rowIndex][columnIndex] = .mine
            updateSurroundingCells(rowIndex, columnIndex)
        }
    }
    
    private mutating func updateSurroundingCells(_ rowIndex: Int, _ columnIndex: Int) {
        // above
        if rowIndex-1 >= 0 {
            if output.field[rowIndex-1][columnIndex] != .mine {
                output.field[rowIndex-1][columnIndex] = .sweep(1)
            }
        }
        // below
        if rowIndex+1 < board.height {
            if output.field[rowIndex+1][columnIndex] != .mine {
                output.field[rowIndex+1][columnIndex] = .sweep(1)
            }
        }
        // to the left
        if columnIndex-1 >= 0 {
            if output.field[rowIndex][columnIndex-1] != .mine {
                output.field[rowIndex][columnIndex-1] = .sweep(1)
            }
        }
        // to the right
        if columnIndex+1 < board.width {
            if output.field[rowIndex][columnIndex+1] != .mine {
                output.field[rowIndex][columnIndex+1] = .sweep(1)
            }
        }
        
    }
}

extension BoardOutput {
    static func new(width: Int, height: Int) -> Self {
        BoardOutput(field: .init(
            repeating: .init(
                repeating: .sweep(0),
                count: width),
            count: height))
    }
}
