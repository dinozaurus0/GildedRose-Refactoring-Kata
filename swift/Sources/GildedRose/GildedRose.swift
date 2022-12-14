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
        for i in 0 ..< items.count {
            if items[i].quality < 50 {
                items[i].quality = items[i].quality + 1
                
                if items[i].name == "Backstage passes to a TAFKAL80ETC concert" {
                    if items[i].sellIn < 11 {
                        if items[i].quality < 50 {
                            items[i].quality = items[i].quality + 1
                        }
                    }
                    
                    if items[i].sellIn < 6 {
                        if items[i].quality < 50 {
                            items[i].quality = items[i].quality + 1
                        }
                    }
                }
            }
            
            if items[i].name != "Sulfuras, Hand of Ragnaros" {
                items[i].sellIn = items[i].sellIn - 1
            }
            
            if items[i].sellIn < 0 {
                if items[i].name != "Aged Brie" {
                    items[i].quality = items[i].quality - items[i].quality
                }
            }
        }
        
        updateItemsQuality()
    }
    
    private func updateItemsQuality() {
        itemsQualityCalculators.forEach { itemQualityCalculator in
            itemQualityCalculator.computeQuality()
            items.append(itemQualityCalculator.item)
        }
    }
}
