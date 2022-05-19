import XCTest
import Minesweeper

class MinesweeperBoardViewModelTests: XCTestCase {

    func test_whenInitialisedWithHeightAndWidthZero_shouldHaveEmptyRows() {
        let sut = MinesweeperBoardViewModel(0, 0)
        XCTAssertEqual(sut.rows.count, 0)
    }

    
}
