//
//  ConjuredItemQualityCalculator.swift
//  
//
//  Created by Vlad Grigore Sima on 21.12.2022.
//

import Foundation

public struct ConjuredItemQualityCalculator: ItemQualityCalculator {
    // MARK: - Properties

    public var item: Item

    // MARK: - Init
    public init(item: Item) {
        self.item = item
    }

    // MARK: - Protocol Conformance

    public func computeQuality() {
        decreaseItemExpirationDate()
        decreaseItemQuality()
    }

    // MARK: - Private Methods
    private func decreaseItemQuality() {
        if item.sellIn > 0 {
            item.quality -= 2
        } else {
            item.quality -= 4
        }
    }
}
