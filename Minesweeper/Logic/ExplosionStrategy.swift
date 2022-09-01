import Combine
import Foundation

public protocol ExplosionStrategy {
    var explosionPublisher: AnyPublisher<IndexPath, Never> { get }
    func trigger(from cellIndex: IndexPath)
    mutating func configure(with boardOutput: BoardOutput)
}

public struct BasicExplosionStrategy: ExplosionStrategy {
    public var explosionPublisher: AnyPublisher<IndexPath, Never> {
        self.explosionSubject.eraseToAnyPublisher()
    }
    
    private let explosionSubject = PassthroughSubject<IndexPath, Never>()
    private var boardOutput: BoardOutput?
    
    public func trigger(from cellIndex: IndexPath) {
        self.boardOutput?
            .field
            .allIndexPaths
            .filter { self.boardOutput?.field[$0] == .mine }
            .forEach(self.explosionSubject.send)
    }
    
    public mutating func configure(with boardOutput: BoardOutput) {
        self.boardOutput = boardOutput
    }
    
    public init() { }
}

extension Collection
where Index == Int,
      Element: Collection,
      Element.Index == Int
{
    var allIndexPaths: [IndexPath] {
        self.enumerated()
            .flatMap { (sectionIndex, section) in
                section.makeIndexPaths(withSection: sectionIndex)
            }
    }
    
    subscript(path: IndexPath) -> Element.Element {
        self[path.section][path.item]
    }
}

extension Collection
where Index == Int
{
    func makeIndexPaths(withSection section: Int) -> [IndexPath] {
        self.indices
            .map { IndexPath(item: $0, section: section) }
    }
}
