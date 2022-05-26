import XCTest
@testable import Minesweeper

class MinesweeperBoardViewModelTests: XCTestCase {

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
    
    // TODO: Use a mock Minesweeper
    
    func test_givenHiddenMine_whenCellActionCalled_shouldRevealMine() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 1, field: [[.mine]])
        var sut = MinesweeperBoardViewModel(1, 1, boardGenerator: boardGenerator)
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        assertMatch(sut.rows, [[.mine]])
    }
    
    private func getCell(viewModel: MinesweeperBoardViewModel, rowIndex: Int, columnIndex: Int) throws -> MinesweeperCell {
        guard rowIndex < viewModel.rows.count else {
            throw TestError.rowIndexOutOfBounds
        }
        let row = viewModel.rows[rowIndex]
        guard columnIndex < row.cells.count else {
            throw TestError.columnIndexOutOfBounds
        }
        return row.cells[columnIndex]
    }
    
    private func assertMatch(_ input: [MinesweeperRow], _ expected: [[MinesweeperCell.State]]) {
        let states = input
            .map(\.cells)
            .map { (cells: [MinesweeperCell]) -> [MinesweeperCell.State] in
                cells.map(\.state)
            }
        
        XCTAssertEqual(states, expected)
    }
    
    enum TestError: Error {
        case rowIndexOutOfBounds
        case columnIndexOutOfBounds
    }
}

extension MinesweeperCell.State: Equatable {
    public static func == (lhs: MinesweeperCell.State, rhs: MinesweeperCell.State) -> Bool {
        switch (lhs, rhs) {
        case (.hidden, .hidden):
            return true
        case (.mine, .mine):
            return true
        case (.sweep(let lhsCount), .sweep(let rhsCount)):
            return lhsCount == rhsCount
        default:
            return false
        }
    }
}
