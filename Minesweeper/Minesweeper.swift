public struct Minesweeper {
    
    let board: BoardSetup
    public var output: BoardOutput
    private var mineCount = 0
    
    public init(board: BoardSetup) {
        self.board = board
        self.output = BoardOutput.new(width: board.width, height: board.height)
    }
    
    public mutating func sweep() {
        countMines()
        for rowIndex in board.field.indices {
            for columnIndex in board.field[rowIndex].indices {
                sweepCell(rowIndex, columnIndex)
            }
        }
    }
    
    private mutating func countMines() {
        for row in board.field {
            for cell in row {
                if cell == .mine {
                    mineCount += 1
                }
            }
        }
    }
    
    private mutating func sweepCell(_ rowIndex: Int, _ columnIndex: Int) {
        let isMine = board.field[rowIndex][columnIndex]
        switch isMine {
        case .mine:
            output.field[rowIndex][columnIndex] = .mine
        case .empty:
            output.field[rowIndex][columnIndex] = .sweep(mineCount)
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
