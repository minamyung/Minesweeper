import Foundation

public protocol BoardGenerator {
    init(height: Int, width: Int, mines: Int)
    func generate() -> BoardSetup
}
