import XCTest
import Minesweeper

class MinesweeperTests: XCTestCase {
    func test_GivenEmptyBoard_ThenReturnEmptyBoard() {
        let input = BoardSetup(height: 0, width: 0, field: [])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: []))
    }

    func test_Given1by1BoardWithMine_ThenReturn1by1BoardWithMine() {
        let input = BoardSetup(height: 1, width: 1, field: [[.mine]])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: [[.mine]]))
    }
    
    func test_Given1by1BoardWithNoMines_ThenReturn1by1BoardWith0() {
        let input = BoardSetup(height: 1, width: 1, field: [[.empty]])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: [[.sweep(0)]]))
    }
    
    func test_Given2by1BoardWithMines_ThenReturn2by1BoardWithMines() {
        let input = BoardSetup(height: 2, width: 1, field: [[.mine], [.mine]])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: [[.mine], [.mine]]))
    }
    
    func test_Given1by2BoardWithMines_ThenReturn1by2BoardWithMines() {
        let input = BoardSetup(height: 1, width: 2, field: [[.mine, .mine]])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: [[.mine, .mine]]))
    }
    
    func test_Given2by2BoardWithMines_ThenReturn2by2BoardWithMines() {
        let input = BoardSetup(height: 2, width: 2, field: [[.mine, .mine],
                                                            [.mine, .mine]])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: [[.mine, .mine],
                                                   [.mine, .mine]]))
    }
    
    func test_Given2by1BoardWithOneMine_ThenReturn2by1BoardWithAMineAndASweep1() {
        let input = BoardSetup(height: 2, width: 1, field: [[.mine], [.empty]])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: [[.mine], [.sweep(1)]]))
    }
    
    func test_Given3by1BoardWithOneMine_ThenReturn3by1BoardWithAMineAndTwoSweep1() {
        let input = BoardSetup(height: 3, width: 1, field: [[.empty], [.mine], [.empty]])
        var minesweeper = Minesweeper(board: input)
        minesweeper.sweep()
        let output = minesweeper.output
        XCTAssertEqual(output, BoardOutput(field: [[.sweep(1)], [.mine], [.sweep(1)]]))
    }
    
//    func test_Given3by1BoardWithLeftMine_ThenReturn3by1BoardWithAMineAndSweep1AndSweep0() {
//        let input = BoardSetup(height: 3, width: 1, field: [[.mine], [.empty], [.empty]])
//        var minesweeper = Minesweeper(board: input)
//        minesweeper.sweep()
//        let output = minesweeper.output
//        XCTAssertEqual(output, BoardOutput(field: [[.mine], [.sweep(1)], [.sweep(0)]]))
//    }
}
