import XCTest
@testable import Minesweeper

class MinesweeperBoardViewModelInitialisationTests: MinesweeperBoardViewModelBaseTests {
    func test_whenInitialisedWithHeightAndWidthZero_shouldHaveEmptyRows() {
        let sut = MinesweeperBoardViewModel(0, 0)
        XCTAssertEqual(sut.rows.count, 0)
    }

    func test_whenInitialised_shouldSetHeightWidthAndMinesOfGenerator() {
        let boardGenerator = SpyBoardGenerator()
        _ = MinesweeperBoardViewModel(1, 2, boardGenerator: boardGenerator)
        XCTAssertEqual(boardGenerator.height, 1)
        XCTAssertEqual(boardGenerator.width, 2)
        XCTAssertEqual(boardGenerator.mines, 0)
    }
    
    func test_whenInitialisedWith10Cells_shouldSetOneMine() throws {
        let boardGenerator = SpyBoardGenerator()
        _ = MinesweeperBoardViewModel(2, 5, boardGenerator: boardGenerator)
        XCTAssertEqual(boardGenerator.height, 2)
        XCTAssertEqual(boardGenerator.width, 5)
        XCTAssertEqual(boardGenerator.mines, 1)
    }
    
    func test_whenInitialisedWith20Cells_shouldSetOneMine() throws {
        let boardGenerator = SpyBoardGenerator()
        _ = MinesweeperBoardViewModel(5, 4, boardGenerator: boardGenerator)
        XCTAssertEqual(boardGenerator.height, 5)
        XCTAssertEqual(boardGenerator.width, 4)
        XCTAssertEqual(boardGenerator.mines, 2)
    }
    
    func test_whenInitialised_shouldSweepBoard() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 1, field: [[.mine]])
        let sut = MinesweeperBoardViewModel(1, 1, boardGenerator: boardGenerator)
        assertMatch(sut.rows, [[.hidden]])
    }
}
