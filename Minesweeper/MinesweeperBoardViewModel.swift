import Foundation

public struct MinesweeperBoardViewModel {
    public var playState = PlayState.inProgress
    public var flagMode = false
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
        self.playState = .inProgress
    }
    
    public mutating func cellAction(for cell: MinesweeperCell) {
        guard
            cell.state.isNotRevealed,
            let index = self.index(for: cell)
        else { return }
        
        if self.flagMode {
            self.toggleCellFlagState(at: index)
        } else {
            self.revealCell(at: index)
            self.updatePlayState()
        }
    }
    
    private mutating func toggleCellFlagState(at index: IndexPath) {
        let currentState = rows[index.section].cells[index.item].state
        let newState: MinesweeperCell.State
        
        switch currentState {
        case .flagged: newState = .hidden
        case .hidden: newState = .flagged
        default: newState = currentState
        }
        
        rows[index.section].cells[index.item].state = newState
    }
    
    private mutating func revealCell(at index: IndexPath) {
        let state = self.getState(for: index)
        
        rows[index.section].cells[index.item].state = state
        
        if state == .sweep(0) {
            self.revealCellsNeighbouring(index)
        }
    }
    
    private func getState(for index: IndexPath) -> MinesweeperCell.State {
        MinesweeperCell.State(
            outputFieldState: minesweeper.output.field[index.section][index.item]
        )
    }
    
    private mutating func revealCellsNeighbouring(_ index: IndexPath) {
        let neighbouringCellIndices = rows
            .enumerated()
            .flatMap { rowIndex, row in
                row.cells.indices.compactMap { cellIndex -> IndexPath? in
                    guard abs(cellIndex - index.item) <= 1,
                          abs(rowIndex - index.section) <= 1 else { return nil }
                    return IndexPath(item: cellIndex, section: rowIndex)
                }
            }
        neighbouringCellIndices
            .map { rows[$0.section].cells[$0.item] }
            .forEach { cellAction(for: $0) }
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
        countCells(in: row) { $0.isSweep }
    }
    
    private func countDetonatedCells(in row: MinesweeperRow) -> Int {
        countCells(in: row) { $0.isMine }
    }
    
    private func countCells(in row: MinesweeperRow, using condition: (MinesweeperCell.State) -> Bool) -> Int {
        row
            .cells
            .map(\.state)
            .filter(condition)
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

public enum PlayState: String {
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
    
    public enum State: Equatable {
        case hidden
        case flagged
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
    
    var isNotRevealed: Bool {
        self == .flagged || self == .hidden
    }
}
