//
//  Constant.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import Foundation

enum Reels {
    
    /// Amount of reels.
    static let totalCount = 3
    
    /// Images that will be added to a reel.
    static let images = ["diamond", "bar", "bell", "cherry", "clever"] //, "banana", "coin", "heart", "seven"]
    
    /// Amount images per one reel. Need be more or equal 6.
    static let imagesPerReel = 6
}
