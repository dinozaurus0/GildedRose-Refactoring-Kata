@testable import GildedRose
import XCTest

internal final class GildedRoseTests: XCTestCase {
}


// MARK: - Regular Items Tests
extension GildedRoseTests {
    func test_updateQuality_withRegularItem_withOneDayPassed_shouldDecreaseSellInAndQualityWithOne() {
        // given
        let items = [createItem(name: "Regular Element", sellIn: 10, quality: 10)]
        let sut = makeSUT(items: items)

        // when
        sut.updateQuality()

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: 9, quality: 9)]
        XCTAssertEqual(sut.items, expectedResult)
    }

    func test_updateQuality_withRegularItem_withSellDatePassed_shouldDecreaseSellInWithOneAndQualityWithTwo() {
        // given
        let items = [createItem(name: "Regular Element", sellIn: 0, quality: 10)]
        let sut = makeSUT(items: items)

        // when
        sut.updateQuality()

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: -1, quality: 8)]
        XCTAssertEqual(sut.items, expectedResult)
    }

    func test_updateQuality_withRegularItem_withQualityReachedZero_shouldDecreaseSellInWithOneAndQualityShouldRemainZero() {
        // given
        let items = [createItem(name: "Regular Element", sellIn: 0, quality: 0)]
        let sut = makeSUT(items: items)

        // when
        sut.updateQuality()

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: -1, quality: 0)]
        XCTAssertEqual(sut.items, expectedResult)
    }
}

// MARK: - Helpers
extension GildedRoseTests {
    private func makeSUT(items: [Item]) -> GildedRose {
        GildedRose(items: items)
    }

    private func createItem(name: String, sellIn: Int, quality: Int) -> Item {
        Item(name: name, sellIn: sellIn, quality: quality)
    }
}
