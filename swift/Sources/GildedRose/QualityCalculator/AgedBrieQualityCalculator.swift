//
//  AgedBrieQualityCalculator.swift
//
//  Created by Vlad Grigore Sima on 13.12.2022.
//

import Foundation

public struct AgedBrieQualityCalculator: ItemQualityCalculator {
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

    private func decreaseItemExpirationDate() {
        item.sellIn -= 1
    }

    private func increaseItemQuality() {
        if item.sellIn < 0 {
            item.quality += 2
        } else {
            item.quality += 1
        }
    }

    private func normaliseItemQuality() {
        if item.quality > 50 {
            item.quality = 50
        }
    }
}
