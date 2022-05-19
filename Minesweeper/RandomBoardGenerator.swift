import Foundation

public struct RandomBoardGenerator: BoardGenerator {
    let height: Int
    let width: Int
    let mines: Int
    var indexSelector: RandomIndexSelector
    
    public init(height: Int, width: Int, mines: Int) {
        self.height = height
        self.width = width
        self.mines = mines
        self.indexSelector = DefaultRandomIndexSelector(
            height: height,
            width: width)
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
