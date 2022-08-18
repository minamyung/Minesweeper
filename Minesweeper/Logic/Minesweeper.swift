public struct Minesweeper {
    let board: BoardSetup
    let surroundingCellTransformation =
        [(-1, -1), (-1, 0), (-1, 1),
         ( 0, -1),          ( 0, 1),
         ( 1, -1), ( 1, 0), ( 1, 1)]
    
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
        surroundingCellTransformation
            .map { (rowIndex+$0, columnIndex+$1) }
            .filter(cellIsUpdateable)
            .forEach { self.incrementMineCount($0, $1) }
    }
    
    private func cellIsUpdateable(_ rowIndex: Int, _ columnIndex: Int) -> Bool {
        return cellIsInBounds(rowIndex, columnIndex)
        && cellIsNotMine(rowIndex, columnIndex)
    }
    
    private func cellIsInBounds(_ rowIndex: Int, _ columnIndex: Int) -> Bool {
        return rowIndex >= 0
        && rowIndex < board.height
        && columnIndex >= 0
        && columnIndex < board.width
    }
    
    private func cellIsNotMine(_ rowIndex: Int, _ columnIndex: Int) -> Bool {
        return output.field[rowIndex][columnIndex] != .mine
    }
    
    private mutating func incrementMineCount(_ rowIndex: Int, _ columnIndex: Int) {
        if case let .sweep(currentMineCount) = output.field[rowIndex][columnIndex] {
            output.field[rowIndex][columnIndex] = .sweep(currentMineCount + 1)
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
