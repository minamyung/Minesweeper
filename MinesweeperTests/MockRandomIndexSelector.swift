import Foundation
import Minesweeper

class MockRandomIndexSelector: RandomIndexSelector {
    var height: Int
    var width: Int
    var mockedValues: [(Int, Int)] = []
    
    required init(height: Int, width: Int) {
        self.height = height
        self.width = width
    }
    
    func getRandomIndex() -> (rowIndex: Int, columnIndex: Int) {
        mockedValues.removeFirst()
    }
}
