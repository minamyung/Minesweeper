import Foundation
import Minesweeper

class SpyBoardGenerator: BoardGenerator {
    var height: Int = 0
    var width: Int = 0
    var mines: Int = 0
    var board = BoardSetup(height: 0, width: 0, field: [[]])
    
    func generate() -> BoardSetup {
        return self.board
    }
}
