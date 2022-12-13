//
//  ItemQualityCalculator.swift
//  
//
//  Created by Vlad Grigore Sima on 13.12.2022.
//

import Foundation

public protocol ItemQualityCalculator {
    var item: Item { get }
    func computeQuality()
}
