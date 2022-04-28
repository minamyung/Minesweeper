import Foundation

public struct MinesweeperBoardViewModel {
    public let rows: [RowViewModel]
    
    public init(_ height: Int, _ width: Int) {
        let boardSetup = RandomBoardGenerator(height: height, width: width, mines: (height*width)/2).generate()
        var minesweeper = Minesweeper(board: boardSetup)
        minesweeper.sweep()
        self.rows = minesweeper
            .output
            .field
            .map(RowViewModel.init)
    }
}

public struct RowViewModel: Identifiable {
    public let id = UUID()
    
    public let cells: [CellViewModel]
}

private extension RowViewModel {
    init(input: [OutputFieldState]) {
        self.cells = input.map(CellViewModel.init)
    }
}

public struct CellViewModel: Identifiable {
    public let id = UUID()
    
    public let state: OutputFieldState
}
