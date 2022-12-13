//
//  RegularItemQualityCalculator.swift
//  
//
//  Created by Vlad Grigore Sima on 13.12.2022.
//

import Foundation

public struct RegularItemQualityCalculator: ItemQualityCalculator {
    // MARK: - Properties

    public let item: Item

    // MARK: - Init

    public init(item: Item) {
        self.item = item
    }

    // MARK: - Protocol Conformance

    public func computeQuality() {
        decreaseItemExpirationDate()
        decreaseItemQuality()
        normaliseItemQuality()
    }

    // MARK: - Private Methods

    private func decreaseItemQuality() {
        if item.sellIn < 0 {
            item.quality -= 2
        } else {
            item.quality -= 1
        }
    }

    private func normaliseItemQuality() {
        if item.quality < 0 {
            item.quality = 0
        }
    }
}
