import Foundation

public protocol RandomIndexSelector {
    var height: Int { get set }
    var width: Int { get set }
    
    func getRandomIndex() -> (rowIndex: Int, columnIndex: Int)
}

struct DefaultRandomIndexSelector: RandomIndexSelector {
    public var height: Int = 0
    public var width: Int = 0
    
    func getRandomIndex() -> (rowIndex: Int, columnIndex: Int) {
        let rowIndex = Int.random(in: 0..<self.height)
        let columnIndex = Int.random(in: 0..<self.width)
        return (rowIndex, columnIndex)
    }
}
