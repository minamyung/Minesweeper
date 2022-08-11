import XCTest
@testable import Minesweeper

class MinesweeperBoardViewModelBaseTests: XCTestCase {
    // TODO: Use a mock Minesweeper
    
    func getCell(viewModel: MinesweeperBoardViewModel, rowIndex: Int, columnIndex: Int) throws -> MinesweeperCell {
        guard rowIndex < viewModel.rows.count else {
            throw TestError.rowIndexOutOfBounds
        }
        let row = viewModel.rows[rowIndex]
        guard columnIndex < row.cells.count else {
            throw TestError.columnIndexOutOfBounds
        }
        return row.cells[columnIndex]
    }
    
    func assertMatch(_ input: [MinesweeperRow], _ expected: [[MinesweeperCell.State]]) {
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
