import XCTest
@testable import Minesweeper

class MinesweeperBoardViewModelFlagTests: MinesweeperBoardViewModelBaseTests {
    func test_shouldStartWithFlagModeOff() {
        let sut = MinesweeperBoardViewModel(0, 0)
        
        XCTAssertFalse(sut.flagMode)
    }
    
    func test_canChangeFlagMode() {
        var sut = MinesweeperBoardViewModel(0, 0)
        
        sut.flagMode.toggle()
    }
    
    func test_givenFlagModeIsOn_whenUsingCellActionOnHiddenCell_shouldChangeThatCellToFlagged() throws {
        var sut = MinesweeperBoardViewModel(1, 1)
        sut.flagMode = true
        
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        assertMatch(sut.rows, [[.flagged]])
    }
    
    func test_givenFlagModeIsOn_whenUsingCellActionOnFlaggedCell_shouldChangeThatCellToHidden() throws {
        var sut = MinesweeperBoardViewModel(1, 1)
        sut.flagMode = true
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        let flaggedMineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: flaggedMineCell)
        
        assertMatch(sut.rows, [[.hidden]])
    }
    
    func test_givenFlagModeIsOff_whenUsingCellActionOnFlaggedCell_shouldNotRevealCell() throws {
        var sut = MinesweeperBoardViewModel(1, 1)
        sut.flagMode = true
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        sut.flagMode = false
        
        let flaggedMineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: flaggedMineCell)
        
        assertMatch(sut.rows, [[.flagged]])
    }
}
