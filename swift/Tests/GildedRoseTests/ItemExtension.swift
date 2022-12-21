//
//  ItemExtension.swift
//  
//
//  Created by Vlad Grigore Sima on 12.12.2022.
//

import Foundation
import GildedRose

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.quality == rhs.quality && lhs.sellIn == rhs.sellIn
    }
}
