@testable import GildedRose
import XCTest

internal final class GildedRoseTests: XCTestCase {}

// MARK: - Regular Items Tests
extension GildedRoseTests {
    func test_updateQuality_withRegularItem_withOneDayPassed_shouldDecreaseSellInAndQualityWithOne() {
        // given
        let itemsQualityCalculator = [createRegularItemQualityCalculator(item: createItem(name: "Regular Element", sellIn: 10, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: 9, quality: 9)]
        XCTAssertEqual(sut.items, expectedResult)
    }

    func test_updateQuality_withRegularItem_withSellDatePassed_shouldDecreaseSellInWithOneAndQualityWithTwo() {
        // given
        let itemsQualityCalculator = [createRegularItemQualityCalculator(item: createItem(name: "Regular Element", sellIn: 0, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        let expectedResult = [createItem(name: "Regular Element", sellIn: -1, quality: 8)]
        XCTAssertEqual(sut.items, expectedResult)
    }

    func test_updateQuality_withRegularItem_withQualityReachedZero_shouldDecreaseSellInWithOneAndQualityShouldRemainZero() {
        // given
        let itemsQualityCalculator = [createRegularItemQualityCalculator(item: createItem(name: "Regular Element", sellIn: 0, quality: 0))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

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
        let itemsQualityCalculator = [createAgedBrieQualityCalculator(item: createItem(name: "Aged Brie", sellIn: 1, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Aged Brie", sellIn: 0, quality: 11)])
    }

    func test_updateQuality_withAgedBrieItem_withSellDatePassed_shouldDecreaseSellInWithOneAndIncreaseQualityWithTwo() {
        // given
        let itemsQualityCalculator = [createAgedBrieQualityCalculator(item: createItem(name: "Aged Brie", sellIn: 0, quality: 5))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Aged Brie", sellIn: -1, quality: 7)])
    }

    func test_updateQuality_withAgedBrieItem_withNoDayRemaining_withQualityReachedFortyNine_shouldDecreaseSellInWithOneAndIncreaseQualityWithOne() {
        // given
        let itemsQualityCalculator = [createAgedBrieQualityCalculator(item: createItem(name: "Aged Brie", sellIn: 0, quality: 49))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Aged Brie", sellIn: -1, quality: 50)])
    }

    func test_updateQuality_withAgedBrieItem_withQualityReachedFifty_shouldDecreaseSellInWithOneAndQualityShouldRemainFifty() {
        // given
        let itemsQualityCalculator = [createAgedBrieQualityCalculator(item: createItem(name: "Aged Brie", sellIn: 10, quality: 50))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Aged Brie", sellIn: 9, quality: 50)])
    }
}

// MARK: - Sulfuras Items Tests
extension GildedRoseTests {
    func test_updateQuality_withSulfurusItem_withOneDayPassed_shouldntDecreaseNeitherQualityNorSellIn() {
        // given
        let itemsQualityCalculator = [createSulfurusQualityCalculator(item: createItem(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)])
    }

    func test_updateQuality_withSulfurusItem_withThreeDaysPassed_shouldntDecreaseNeitherQualityNorSellIn() {
        // given
        let itemsQualityCalculator = [createSulfurusQualityCalculator(item: createItem(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 3)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)])
    }
}

// MARK: - Backstage Passes Items Tests
extension GildedRoseTests {
    func test_updateQuality_withBackstagePassItem_withMoreThanTenDays_shouldDecreaseSellInWithOneAndIncreaseQualityWithOne() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 12, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 11)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanTenDays_shouldDecreaseSellInWithOneAndIncreaseQualityWithTwo() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 12)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanSixDays_shouldDecreaseSellInWithOneAndIncreaseQualityWithTwo() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 7, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 12)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanFiveDays_shouldDecreaseSellInWithOneAndIncreaseQualityWithThree() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 13)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanOneDay_shouldDecreaseSellInWithOneAndIncreaseQualityWithThree() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 10))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 13)])
    }

    func test_updateQuality_withBackstagePassItem_withSellInReachedZero_shouldDecreaseSellInWithOneAndQualityBecomeZero() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 20))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: -1, quality: 0)])
    }

    func test_updateQuality_withBackstagePassItem_withMoreThanTenDaysLeft_shouldDecreaseSellInWithOneAndQualityShouldRemainFifty() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 12, quality: 50))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 50)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanTenDaysRemaining_withQualityReachedFortyNine_shouldDecreaseSellInWithOneAndIncreaseQualityWithOne() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 49))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 9, quality: 50)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanFiveDaysRemaining_shouldDecreaseSellInWithOneAndIncreaseQualityWithTwo() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 48))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 4, quality: 50)])
    }

    func test_updateQuality_withBackstagePassItem_withLessThanFiveDaysRemaining_shouldDecreaseSellInWithOneAndIncreaseQualityWithOne() {
        // given
        let itemsQualityCalculator = [createBackstageQualityCalculator(item: createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 49))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        XCTAssertEqual(sut.items, [createItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 4, quality: 50)])
    }
}

// MARK: - Conjured Items Tests
extension GildedRoseTests {
    func test_updateQuality_withConjuredItem_withOneDayPassed_shouldDecreaseSellInAndQualityWithTwo() {
        // given
        let itemsQualityCalculator = [ConjuredItemQualityCalculator(item: createItem(name: "Conjured Mana Cake", sellIn: 10, quality: 20))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        let expectedResult = [createItem(name: "Conjured Mana Cake", sellIn: 9, quality: 18)]
        XCTAssertEqual(sut.items, expectedResult)
    }

    func test_updateQuality_withConjuredItem_withSellDatePassed_shouldDecreaseSellInWithOneAndQualityWithFour() {
        // given
        let itemsQualityCalculator = [ConjuredItemQualityCalculator(item: createItem(name: "Conjured Mana Cake", sellIn: 0, quality: 11))]
        let sut = makeSUT(itemsQualityCalculator: itemsQualityCalculator)

        // when
        emulateDaysPassing(sut: sut, numberOfDaysPassed: 1)

        // then
        let expectedResult = [createItem(name: "Conjured Mana Cake", sellIn: -1, quality: 7)]
        XCTAssertEqual(sut.items, expectedResult)
    }
}

// MARK: - Helpers
extension GildedRoseTests {
    private func makeSUT(itemsQualityCalculator: [ItemQualityCalculator] = []) -> GildedRose {
        GildedRose(itemsQualityCalculators: itemsQualityCalculator)
    }

    private func createItem(name: String, sellIn: Int, quality: Int) -> Item {
        Item(name: name, sellIn: sellIn, quality: quality)
    }

    private func createRegularItemQualityCalculator(item: Item) -> RegularItemQualityCalculator {
        RegularItemQualityCalculator(item: item)
    }

    private func createAgedBrieQualityCalculator(item: Item) -> AgedBrieQualityCalculator {
        AgedBrieQualityCalculator(item: item)
    }

    private func createSulfurusQualityCalculator(item: Item) -> SulfurusQualityCalculator {
        SulfurusQualityCalculator(item: item)
    }

    private func createBackstageQualityCalculator(item: Item) -> BackstagePassQualityCalculator {
        BackstagePassQualityCalculator(item: item)
    }

    private func emulateDaysPassing(sut: GildedRose, numberOfDaysPassed: Int) {
        (0..<numberOfDaysPassed).forEach { _ in
            sut.updateQuality()
        }
    }
}
