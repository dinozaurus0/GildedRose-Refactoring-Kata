public class GildedRose {
    public var items: [Item]
    private let itemsQualityCalculators: [ItemQualityCalculator]
    
    public init(items: [Item]) {
        self.items = items
        self.itemsQualityCalculators = []
    }
    
    public init(items: [Item], itemsQualityCalculators: [ItemQualityCalculator]) {
        self.items = items
        self.itemsQualityCalculators = itemsQualityCalculators
    }

    public func updateQuality() {
        updateItemsQuality()
    }
    
    private func updateItemsQuality() {
        itemsQualityCalculators.forEach { itemQualityCalculator in
            itemQualityCalculator.computeQuality()
        }

        // TODO: This will be removed later
        if (items.isEmpty) {
            items = itemsQualityCalculators.map { $0.item }
        }
    }
}
