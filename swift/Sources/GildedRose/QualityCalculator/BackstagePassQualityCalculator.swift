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
    }

    // MARK: - Private Methods

    private func increaseItemQuality() {
        if item.sellIn < 6 {
            item.quality += 3
        } else if item.sellIn < 11 {
            item.quality += 2
        } else {
            item.quality += 1
        }
    }
}
