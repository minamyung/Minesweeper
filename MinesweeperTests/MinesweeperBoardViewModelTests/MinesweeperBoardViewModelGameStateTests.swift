import XCTest
@testable import Minesweeper

class MinesweeperBoardViewModelGameStateTests: MinesweeperBoardViewModelBaseTests {
    
    func test_givenHiddenMine_whenCellActionCalled_shouldSetGameLost() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 1, field: [[.mine]])
        var sut = MinesweeperBoardViewModel(1, 1, boardGenerator: boardGenerator)
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        XCTAssertEqual(sut.playState, .lost)
    }
    
    func test_givenNewGame_whenNoCellActionCalled_shouldHaveGameInProgress() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 1, field: [[.mine]])
        let sut = MinesweeperBoardViewModel(1, 1, boardGenerator: boardGenerator)
        XCTAssertEqual(sut.playState, .inProgress)
    }
    
    func test_givenEmptyCell_whenCellActionCalledOnLastEmptyCell_shouldSetGameWon() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 1, field: [[.empty]])
        var sut = MinesweeperBoardViewModel(1, 1, boardGenerator: boardGenerator)
        
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        XCTAssertEqual(sut.playState, .won)
    }
    
    func test_givenEmptyCells_whenCellActionCalledOnLastEmptyCell_shouldSetGameWon() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 2, field: [[.empty, .empty]])
        var sut = MinesweeperBoardViewModel(1, 2, boardGenerator: boardGenerator)
        
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        let lastMineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 1)
        sut.cellAction(for: lastMineCell)
        
        XCTAssertEqual(sut.playState, .won)
    }
    
    func test_givenEmptyCells_whenCellActionCalledOnLastEmptyCellInDifferentOrder_shouldSetGameWon() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 1, width: 2, field: [[.empty, .empty]])
        var sut = MinesweeperBoardViewModel(1, 2, boardGenerator: boardGenerator)
        
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 1)
        sut.cellAction(for: mineCell)
        let lastMineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: lastMineCell)
        
        XCTAssertEqual(sut.playState, .won)
    }
    
    func test_given3By1EmptyCells_whenCellActionCalledOnFirstEmptyCell_shouldHaveGameInProgress() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 3, width: 1, field: [[.empty], [.mine], [.empty]])
        var sut = MinesweeperBoardViewModel(3, 1, boardGenerator: boardGenerator)
        
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        XCTAssertEqual(sut.playState, .inProgress)
    }
    
    func test_given2By1EmptyCells_whenCellActionCalledOnLastEmptyCell_shouldSetGameWon() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 2, width: 1, field: [[.empty], [.empty]])
        var sut = MinesweeperBoardViewModel(2, 1, boardGenerator: boardGenerator)
        
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        let lastMineCell = try getCell(viewModel: sut, rowIndex: 1, columnIndex: 0)
        sut.cellAction(for: lastMineCell)
        
        XCTAssertEqual(sut.playState, .won)
    }
    
    func test_givenEmptyCellAndMine_whenCellActionCalledOnEmptyCell_shouldSetGameWon() throws {
        let boardGenerator = SpyBoardGenerator()
        boardGenerator.board = BoardSetup(height: 2, width: 1, field: [[.empty], [.mine]])
        var sut = MinesweeperBoardViewModel(2, 1, boardGenerator: boardGenerator)
        
        let mineCell = try getCell(viewModel: sut, rowIndex: 0, columnIndex: 0)
        sut.cellAction(for: mineCell)
        
        XCTAssertEqual(sut.playState, .won)
    }
    
    func test_givenLostGame_whenReset_shouldSetToInProgress() {
        let boardGenerator = SpyBoardGenerator()
        var sut = MinesweeperBoardViewModel(1, 1, boardGenerator: boardGenerator)
        sut.playState = .lost
        
        sut.reset()
        
        XCTAssertEqual(sut.playState, .inProgress)
    }
}
