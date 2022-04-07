import XCTest
import Minesweeper

class MinesweeperBoardViewModelTests: XCTestCase {

    func test_givenWidthAndHeight_canCreateViewModel() {
        let viewModel = MinesweeperBoardViewModel(1, 1)
        XCTAssert(viewModel is MinesweeperBoardViewModel)
    }
    
    func test_givenViewModel_boardIsInitialised() {
        let viewModel = MinesweeperBoardViewModel(1, 1)
        let board = viewModel.board
        XCTAssert(board is BoardOutput)
    }

}
