public enum InputFieldState: Equatable {
    case mine
    case empty
}

public enum OutputFieldState: Equatable, Hashable {
    case mine
    case sweep(Int)
}

public struct BoardSetup {
    public init(height: Int, width: Int, field: [[InputFieldState]]) {
        self.height = height
        self.width = width
        self.field = field
    }
    
    public let height: Int
    public let width: Int
    public let field: [[InputFieldState]]
}

public struct BoardOutput: Equatable {
    public init(field: [[OutputFieldState]]) {
        self.field = field
    }
    
    public var field: [[OutputFieldState]]
}

