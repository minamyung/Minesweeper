import Foundation
import XCTest
import Minesweeper

class BoardGeneratorTests: XCTestCase {
    func test_GivenHeightAndWidth0_ShouldGenerate0by0Board() {
        let sut = RandomBoardGenerator(height: 0, width: 0, mines: 0)
        let board = sut.generate()
        XCTAssertEqual(board.height, 0)
        XCTAssertEqual(board.width, 0)
        XCTAssertEqual(board.field, [])
    }
    
    func test_GivenHeight1AndWidth0_ShouldGenerate1by0Board() {
        let sut = RandomBoardGenerator(height: 1, width: 0, mines: 0)
        let board = sut.generate()
        XCTAssertEqual(board.height, 1)
        XCTAssertEqual(board.width, 0)
        XCTAssertEqual(board.field, [[]])
    }
    
    func test_GivenHeight0AndWidth1_ShouldGenerate0by1Board() {
        let sut = RandomBoardGenerator(height: 0, width: 1, mines: 0)
        let board = sut.generate()
        XCTAssertEqual(board.height, 0)
        XCTAssertEqual(board.width, 1)
        XCTAssertEqual(board.field, [])
    }
    
    func test_GivenHeight1AndWidth1AndNoMines_ShouldGenerate1by1BoardWithNoMines() {
        let sut = RandomBoardGenerator(height: 1, width: 1, mines: 0)
        let board = sut.generate()
        XCTAssertEqual(board.height, 1)
        XCTAssertEqual(board.width, 1)
        XCTAssertEqual(board.field, [[.empty]])
    }
    
    func test_GivenHeight2AndWidth2AndNoMines_ShouldGenerate2by2BoardWithNoMines() {
        let sut = RandomBoardGenerator(height: 2, width: 2, mines: 0)
        let board = sut.generate()
        XCTAssertEqual(board.height, 2)
        XCTAssertEqual(board.width, 2)
        XCTAssertEqual(board.field, [[.empty, .empty],
                                     [.empty, .empty]])
    }
    
    func test_GivenHeight1AndWidth1And1Mine_ShouldGenerate1by1BoardWith1Mine() {
        let mockIndexSelector = MockRandomIndexSelector(height: 1, width: 1)
        mockIndexSelector.mockedValues.append((0,0))
        var sut = RandomBoardGenerator(height: 1, width: 1, mines: 1)
        sut.setIndexSelector(to: mockIndexSelector)
        let board = sut.generate()
        XCTAssertEqual(board.height, 1)
        XCTAssertEqual(board.width, 1)
        XCTAssertEqual(board.field, [[.mine]])
    }
    
    func test_GivenHeight2AndWidth2And4Mines_ShouldGenerate2by2BoardWith4Mines() {
        let mockIndexSelector = MockRandomIndexSelector(height: 2, width: 2)
        mockIndexSelector.mockedValues = [(0,0), (1,0), (0,1), (1,1)]
        var sut = RandomBoardGenerator(height: 2, width: 2, mines: 4)
        sut.setIndexSelector(to: mockIndexSelector)
        let board = sut.generate()
        XCTAssertEqual(board.height, 2)
        XCTAssertEqual(board.width, 2)
        XCTAssertEqual(board.field, [[.mine, .mine],
                                     [.mine, .mine]])
    }
    
    func test_GivenSameMineIndexSeveralTimes_ShouldGetADifferentIndex() {
        let mockIndexSelector = MockRandomIndexSelector(height: 2, width: 2)
        mockIndexSelector.mockedValues = [(1,0), (1,0), (0,1), (1,1)]
        var sut = RandomBoardGenerator(height: 2, width: 2, mines: 3)
        sut.setIndexSelector(to: mockIndexSelector)
        let board = sut.generate()
        XCTAssertEqual(board.height, 2)
        XCTAssertEqual(board.width, 2)
        XCTAssertEqual(board.field, [[.empty, .mine],
                                     [.mine, .mine]])
    }
}

extension RandomBoardGenerator {
    init(height: Int, width: Int, mines: Int) {
        var generator = Self()
        generator.height = height
        generator.width = width
        generator.mines = mines
        self = generator
    }
}
