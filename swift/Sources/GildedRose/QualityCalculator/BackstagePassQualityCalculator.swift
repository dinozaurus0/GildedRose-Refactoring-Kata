//
//  BackstageQualityCalculator.swift
//  
//
//  Created by Vlad Grigore Sima on 17.12.2022.
//

import Foundation

public struct BackstagePassQualityCalculator: ItemQualityCalculator {
    // MARK: - Properties

    public let item: Item

    // MARK: - Init

    public init(item: Item) {
        self.item = item
    }

    // MARK: - Protocol Conformance

    public func computeQuality() {
        decreaseItemExpirationDate()
        increaseItemQuality()
        normaliseItemQuality()
    }

    // MARK: - Private Methods

    private func increaseItemQuality() {
        guard item.sellIn >= 0 else {
            item.quality = 0
            return
        }

        guard item.sellIn >= 6 else {
            item.quality += 3
            return
        }

        guard item.sellIn >= 11 else {
            item.quality += 2
            return
        }
        
        item.quality += 1
    }
    
    private func normaliseItemQuality() {
        if item.quality > 50 {
            item.quality = 50
        }
    }
}
