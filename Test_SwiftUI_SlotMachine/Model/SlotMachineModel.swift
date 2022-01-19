//
//  SlotMachineModel.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import Foundation

class SlotMachineModel {
    private var reels: [[Int]] = []
    
    init() {
        for _ in 0 ..< Reels.totalCount {
            reels.append(Array(repeating: 0, count: Reels.imagesPerReel))
        }
    }

    /// Returns an array with the new random data for the all reels.
    ///   - parameters:
    ///     - isScrollDown: nil - array is refilled completely, true - array is refilled from index = 3 to the end, false - array is refilled from 0 to array size - 3.
    public func fillReelsWithNewData(_ isScrollDown: Bool? = nil) -> [[Int]] {
        var range = 0 ..< Reels.imagesPerReel
        if let isScrollDown = isScrollDown {
            range = isScrollDown ? 3 ..< Reels.imagesPerReel : 0 ..< Reels.imagesPerReel - 3
        }
        for i in 0 ..< Reels.totalCount {
            for j in range {
                reels[i][j] = Int.random(in: 0 ..< Reels.images.count)
            }
        }
        return reels
    }
}

