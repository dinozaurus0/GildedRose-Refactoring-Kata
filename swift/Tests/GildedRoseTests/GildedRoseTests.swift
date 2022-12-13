@testable import GildedRose
import XCTest

internal final class GildedRoseTests: XCTestCase {}

// MARK: - Regular Items Tests
extension GildedRoseTests {
    func test_updateQuality_withRegularItem_withOneDayPassed_shouldDecreaseSellInAndQualityWithOne() {
        // given
        let items = [createItem(name: "Regular Element", sellIn: 10, quality: 10)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: 9, quality: 9)]
        XCTAssertEqual(sut.items, expectedResult)
    }

    func test_updateQuality_withRegularItem_withSellDatePassed_shouldDecreaseSellInWithOneAndQualityWithTwo() {
        // given
        let items = [createItem(name: "Regular Element", sellIn: 0, quality: 10)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: -1, quality: 8)]
        XCTAssertEqual(sut.items, expectedResult)
    }

    func test_updateQuality_withRegularItem_withQualityReachedZero_shouldDecreaseSellInWithOneAndQualityShouldRemainZero() {
        // given
        let items = [createItem(name: "Regular Element", sellIn: 0, quality: 0)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: -1, quality: 0)]
        XCTAssertEqual(sut.items, expectedResult)
    }
}

// MARK: - Aged Brie Items Tests
extension GildedRoseTests {
    func test_updateQuality_withAgedBrieItem_withOneDayPassed_shouldDecreaseSellInAndIncreaseQualityWithOne() {
        // given
        let itemsQualityCalculator = [AgedBrieQualityCalculator(item: Item(name: "Aged Brie", sellIn: 1, quality: 10))]
        let sut = makeSUT(items: [], itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Aged Brie", sellIn: 0, quality: 11)])
    }

    func test_updateQuality_withAgedBrieItem_withSellDatePassed_shouldDecreaseSellInWithOneAndIncreaseQualityWithTwo() {
        // given
        let itemsQualityCalculator = [AgedBrieQualityCalculator(item: Item(name: "Aged Brie", sellIn: 0, quality: 5))]
        let sut = makeSUT(items: [], itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Aged Brie", sellIn: -1, quality: 7)])
    }

    func test_updateQuality_withAgedBrieItem_withQualityReachedFortyNine_shouldDecreaseSellInWithOneAndIncreaseQualityWithOne() {
        // given
        let itemsQualityCalculator = [AgedBrieQualityCalculator(item: Item(name: "Aged Brie", sellIn: 0, quality: 49))]
        let sut = makeSUT(items: [], itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Aged Brie", sellIn: -1, quality: 50)])
    }

    func test_updateQuality_withAgedBrieItem_withQualityReachedFifty_shouldDecreaseSellInWithOneAndQualityShouldRemainFifty() {
        // given
        let itemsQualityCalculator = [AgedBrieQualityCalculator(item: Item(name: "Aged Brie", sellIn: 10, quality: 50))]
        let sut = makeSUT(items: [], itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Aged Brie", sellIn: 9, quality: 50)])
    }
}

// MARK: - Sulfuras Items Tests
extension GildedRoseTests {
    func test_updateQuality_withSulfurusItem_withOneDayPassed_shouldntDecreaseNeitherQualityNorSellIn() {
        // given
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)])
    }

    func test_updateQuality_withSulfurusItem_withThreeDaysPassed_shouldntDecreaseNeitherQualityNorSellIn() {
        // given
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 3)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)])
    }
}

// MARK: - Backstage Passes Items Tests
extension GildedRoseTests {
    func test_updateQuality_withBackstagePassItem_withOneDayPassed_shouldDecreaseSellInWithOneAndIncreaseQualityWithTwo() {
        // given
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 14, quality: 10)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 13, quality: 11)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanTenDays_shouldDecreaseSellInWithOneAndIncreaseQualityWithTwo() {
        // given
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 10)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 9, quality: 12)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanFiveDays_shouldDecreaseSellInWithOneAndIncreaseQualityWithThree() {
        // given
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 10)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 4, quality: 13)])
    }

    func test_updateQuality_withBackstagePassItem_withSellInReachedZero_shouldDecreaseSellInWithOneAndQualityBecomeZero() {
        // given
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 20)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: -1, quality: 0)])
    }

    func test_updateQuality_withBackstagePassItem_withQualityReachedFifty_shouldDecreaseSellInWithOneAndQualityShouldRemainFifty() {
        // given
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 50)]
        let sut = makeSUT(items: items)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 9, quality: 50)])
    }
}

// MARK: - Helpers
extension GildedRoseTests {
    private func makeSUT(items: [Item], itemsQualityCalculator: [ItemQualityCalculator] = []) -> GildedRose {
        GildedRose(items: items, itemsQualityCalculators: itemsQualityCalculator)
    }

    private func createItem(name: String, sellIn: Int, quality: Int) -> Item {
        Item(name: name, sellIn: sellIn, quality: quality)
    }

    private func emulateDaysPassing(sut: GildedRose, numberOfDaysPassed: Int) {
        (0..<numberOfDaysPassed).forEach { _ in
            sut.updateQuality()
        }
    }
}
