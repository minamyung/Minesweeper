import Foundation

public struct MinesweeperBoardViewModel {
    public let board: BoardOutput
    
    public init(_ height: Int, _ width: Int) {
        let boardSetup = RandomBoardGenerator(height: height, width: width, mines: (height*width)/2).generate()
        var minesweeper = Minesweeper(board: boardSetup)
        minesweeper.sweep()
        self.board = minesweeper.output
    }
}
