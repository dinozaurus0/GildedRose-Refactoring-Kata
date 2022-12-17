//
//  SulfurusQualityCalculator.swift
//  
//
//  Created by Vlad Grigore Sima on 14.12.2022.
//

import Foundation

public struct SulfurusQualityCalculator: ItemQualityCalculator {
    // MARK: - Properties

    public let item: Item

    // MARK: - Init

    public init(item: Item) {
        self.item = item
    }

    // MARK: - Protocol Conformance

    public func computeQuality() {
        item.sellIn = item.sellIn
        item.quality = item.quality
    }
}
