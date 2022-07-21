import XCTest
@testable import Minesweeper

class MinesweeperBoardViewModelCellActionTests: MinesweeperBoardViewModelBaseTests {
    
    func test_givenHiddenMine_whenCellActionCalled_shouldRevealMine() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 1, field: [[.mine]])
        var sut = MinesweeperBoardViewModel(1, 1, boardGenerator: boardGenerator)
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        assertMatch(sut.rows, [[.mine]])
    }
    
    func test_givenSweepValue0_whenCellActionCalled_shouldRevealAllNearbyCells() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 3, width: 3, field: [[.empty, .empty, .empty],
                                                                       [.empty, .empty, .empty],
                                                                       [.empty, .empty, .empty]])
        var sut = MinesweeperBoardViewModel(3, 3, boardGenerator: boardGenerator)
        let mineCell = try getCell(viewModel: sut, rowIndex: 1, columnIndex: 1)
        sut.cellAction(for: mineCell)
        
        assertMatch(sut.rows, [[.sweep(0), .sweep(0), .sweep(0)],
                               [.sweep(0), .sweep(0), .sweep(0)],
                               [.sweep(0), .sweep(0), .sweep(0)]])
    }
    
    func test_givenBoardWithOneMine_whenCellActionCalledOnEmptyCell_shouldRevealAllCellsNotNeighbouringTheMine() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 3, width: 3, field: [[.empty, .empty, .empty],
                                                                       [.empty, .empty, .empty],
                                                                       [.empty, .empty, .mine]])
        var sut = MinesweeperBoardViewModel(3, 3, boardGenerator: boardGenerator)
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        assertMatch(sut.rows, [[.sweep(0), .sweep(0), .sweep(0)],
                               [.sweep(0), .sweep(1), .sweep(1)],
                               [.sweep(0), .sweep(1), .hidden]])
    }
    
    func test_given1by4BoardWithOneMine_whenCellActionCalledOnSweep0Cell_shouldRevealNeighbouringCells() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 4, field: [[.empty, .empty, .mine, .empty]])
        var sut = MinesweeperBoardViewModel(1, 4, boardGenerator: boardGenerator)
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        assertMatch(sut.rows, [[.sweep(0), .sweep(1), .hidden, .hidden]])
    }
}
