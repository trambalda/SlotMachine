//
//  Reel.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import SwiftUI

struct ReelView: View {
    @Binding var reel: [Int]
    let startIndex: Int

    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(0 ..< Reels.imagesPerReel) { index in
                Image(Reels.images[reel[index]])
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .background(Color(Color.RGBColorSpace.sRGB, red: 0, green: 0, blue: 0, opacity: 0.1))
                    .cornerRadius(20)
                    .id(startIndex + index)
            }
        }
    }
}

