import Foundation

public protocol RandomIndexSelector {
    init(height: Int, width: Int)
    
    func getRandomIndex() -> (rowIndex: Int, columnIndex: Int)
}

struct DefaultRandomIndexSelector: RandomIndexSelector {
    private let height: Int
    private let width: Int
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
    }
    
    func getRandomIndex() -> (rowIndex: Int, columnIndex: Int) {
        let rowIndex = Int.random(in: 0..<self.height)
        let columnIndex = Int.random(in: 0..<self.width)
        return (rowIndex, columnIndex)
    }
}
