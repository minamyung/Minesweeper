import Foundation

public struct MinesweeperBoardViewModel {
    public var rows: [MinesweeperRow] = []
    private let height: Int
    private let width: Int
    private var minesweeper: Minesweeper!
    
    public init(_ height: Int, _ width: Int) {
        self.height = height
        self.width = width
        self.reset()
    }
    
    public mutating func reset() {
        let boardSetup = RandomBoardGenerator(
            height: self.height,
            width: self.width,
            mines: (self.height * self.width)/10)
            .generate()
        var minesweeper = Minesweeper(board: boardSetup)
        minesweeper.sweep()
        self.minesweeper = minesweeper
        self.rows = minesweeper
            .output
            .field
            .map(MinesweeperRow.init)
    }
    
    public mutating func cellAction(for cell: MinesweeperCell) {
        guard let index = self.index(for: cell) else { return }
        let state = MinesweeperCell.State(
            outputFieldState: minesweeper.output.field[index.section][index.item]
            )

        rows[index.section].cells[index.item].state = state
    }
    
    private func index(for targetCell: MinesweeperCell) -> IndexPath? {
        for (rowIndex, row) in rows.enumerated() {
            for (cellIndex, cell) in row.cells.enumerated() {
                if cell.id == targetCell.id {
                    return IndexPath(item: cellIndex, section: rowIndex)
                }
            }
        }
        return nil
    }
}

public struct MinesweeperRow: Identifiable {
    public let id = UUID()
    public var cells: [MinesweeperCell]
}

private extension MinesweeperRow {
    init(input: [OutputFieldState]) {
        self.cells = input
            .map { _ in 
                MinesweeperCell.init(
                    state: .hidden
                )
            }
    }
}

public struct MinesweeperCell: Identifiable {
    public let id = UUID()
    public var state: State

    public enum State {
        case hidden
        case mine
        case sweep(Int)
        
        init(outputFieldState: OutputFieldState) {
            switch outputFieldState {
            case .mine:
                self = MinesweeperCell.State.mine
            case .sweep(let count):
                self = MinesweeperCell.State.sweep(count)
            }
        }
    }
}


