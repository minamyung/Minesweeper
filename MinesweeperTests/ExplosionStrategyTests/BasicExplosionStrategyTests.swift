import Minesweeper
import XCTest

class BasicExplosionStrategyTests: XCTestCase {
    func test_init() {
        let _: ExplosionStrategy = BasicExplosionStrategy()
    }
    
    func test_givenConfiguredWithMine_whenMineIsTriggered_thenShouldPublishExplosion() throws {
        var sut: ExplosionStrategy = BasicExplosionStrategy()
        sut.configure(with: BoardOutput(field: [[.mine]]))
        var publishedValue: IndexPath?
        let subscriber = sut
            .explosionPublisher
            .sink { publishedValue = $0 }
        
        sut.trigger(from: IndexPath(item: 0, section: 0))
                    
        subscriber.cancel()
        XCTAssertEqual(publishedValue, IndexPath(item: 0, section: 0))
    }
    
    func test_givenConfiguredWith2Mines_whenMineIsTriggered_thenShouldPublish2Explosions() throws {
        var sut: ExplosionStrategy = BasicExplosionStrategy()
        sut.configure(with: BoardOutput(field: [[.mine, .mine]]))
        var publishedValues: [IndexPath] = []
        let subscriber = sut
            .explosionPublisher
            .sink { publishedValues.append($0) }
        
        sut.trigger(from: IndexPath(item: 0, section: 0))
                    
        subscriber.cancel()
        XCTAssertEqual(publishedValues.count, 2)
        XCTAssert(publishedValues.contains(IndexPath(item: 0, section: 0)))
        XCTAssert(publishedValues.contains(IndexPath(item: 1, section: 0)))
    }
    
    func test_givenConfiguredWith1MineAnd1Gap_whenMineIsTriggered_thenShouldPublishExplosion() throws {
        var sut: ExplosionStrategy = BasicExplosionStrategy()
        sut.configure(with: BoardOutput(field: [[.mine, .sweep(1)]]))
        var publishedValues: [IndexPath] = []
        let subscriber = sut
            .explosionPublisher
            .sink { publishedValues.append($0) }
        
        sut.trigger(from: IndexPath(item: 0, section: 0))
                    
        subscriber.cancel()
        XCTAssertEqual(publishedValues.count, 1)
        XCTAssert(publishedValues.contains(IndexPath(item: 0, section: 0)))
    }
}

// TODO: Notify consumer when explosions have all been triggered
