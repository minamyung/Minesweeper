import Foundation

public struct RandomBoardGenerator: BoardGenerator {
    public var height: Int = 0 {
        didSet { self.indexSelector.height = self.height }
    }
    
    public var width: Int = 0 {
        didSet { self.indexSelector.width = self.width }
    }
    
    public var mines: Int = 0 
    var indexSelector: RandomIndexSelector = DefaultRandomIndexSelector()
    
    public init() {
    }
    
    public mutating func setIndexSelector(to indexSelector: RandomIndexSelector) {
        self.indexSelector = indexSelector
    }
    
    public func generate() -> BoardSetup {
        let row: [InputFieldState] = Array(
            repeating: .empty,
            count: self.width)
        var field: [[InputFieldState]] = Array(
            repeating: row,
            count: self.height)
        for _ in 0..<self.mines {
            var randomIndex = self.indexSelector.getRandomIndex()
            while field[randomIndex.rowIndex][randomIndex.columnIndex] == .mine {
                randomIndex = self.indexSelector.getRandomIndex()
            }
            field[randomIndex.rowIndex][randomIndex.columnIndex] = .mine
        }
        return BoardSetup(
            height: self.height,
            width: self.width,
            field: field)
    }
}
