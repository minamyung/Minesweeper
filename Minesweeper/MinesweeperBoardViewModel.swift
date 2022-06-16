import Foundation

public struct MinesweeperBoardViewModel {
    public var playState = PlayState.inProgress
    public var rows: [MinesweeperRow] = []
    private let boardGenerator: BoardGenerator
    private let height: Int
    private let width: Int
    private var minesweeper: Minesweeper!
    
    public init(
        _ height: Int,
        _ width: Int,
        boardGenerator: BoardGenerator = RandomBoardGenerator()
    ) {
        self.height = height
        self.width = width
        var boardGenerator = boardGenerator
        boardGenerator.height = self.height
        boardGenerator.width = self.width
        boardGenerator.mines = (self.height * self.width)/10
        self.boardGenerator = boardGenerator
        self.reset()
    }
    
    public mutating func reset() {
        let boardSetup = self.boardGenerator.generate()
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
        
        self.updatePlayState()
    }
    
    private mutating func updatePlayState() {
        let detonatedCellCount = rows
            .map(countDetonatedCells)
            .reduce(0, +)
        
        if detonatedCellCount > 0 {
            self.playState = .lost
            return
        }
        
        let sweptCellCount = rows
            .map(countSweptCells)
            .reduce(0, +)
        
        if sweptCellCount == width * height - numberOfMines {
            self.playState = .won
        }
    }
    
    private func countSweptCells(in row: MinesweeperRow) -> Int {
        row
            .cells
            .filter { $0.state.isSweep }
            .count
    }
    
    private func countDetonatedCells(in row: MinesweeperRow) -> Int {
        row
            .cells
            .filter { $0.state.isMine }
            .count
    }
    
    private var numberOfMines: Int {
        minesweeper
            .output
            .field
            .flatMap(covertToStates)
            .map(\.isMine)
            .filter { $0 }
            .count
    }
    
    private func covertToStates(_ input: [OutputFieldState]) -> [MinesweeperCell.State] {
        input.map(MinesweeperCell.State.init)
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

public enum PlayState {
    case inProgress
    case lost
    case won
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

extension MinesweeperCell.State {
    var isSweep: Bool {
        guard case .sweep = self else { return false }
        return true
    }
    
    var isMine: Bool {
        guard case .mine = self else { return false }
        return true
    }
}
