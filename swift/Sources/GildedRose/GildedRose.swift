public class GildedRose {

    // MARK: - Properties

    public var items: [Item] {
        itemsQualityCalculators.map { $0.item }
    }

    private let itemsQualityCalculators: [ItemQualityCalculator]

    // MARK: - Init

    public init(itemsQualityCalculators: [ItemQualityCalculator]) {
        self.itemsQualityCalculators = itemsQualityCalculators
    }

    // MARK: - Public method
    
    public func updateQuality() {
        itemsQualityCalculators.forEach { itemQualityCalculator in
            itemQualityCalculator.computeQuality()
        }
    }
}
