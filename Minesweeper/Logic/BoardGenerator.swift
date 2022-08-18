import Foundation

public protocol BoardGenerator {
    var height: Int { get set }
    var width: Int { get set }
    var mines: Int { get set }
    
    func generate() -> BoardSetup
}
