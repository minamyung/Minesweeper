import Foundation
import Minesweeper

class SpyBoardGenerator: BoardGenerator {
    var height: Int = 0
    var width: Int = 0
    var mines: Int = 0
    var board: BoardSetup!
    
    func generate() -> BoardSetup {
        return self.board
    }
}
