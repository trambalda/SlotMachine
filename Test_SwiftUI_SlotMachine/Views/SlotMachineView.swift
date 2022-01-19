//
//  SlotMachineView.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import SwiftUI

struct SlotMachineView: View {
    @State private var isScrollDown = true
    @State var reels: [[Int]]
    private let model = SlotMachineModel()
    
    init() {
        _reels = State(initialValue: model.fillReelsWithNewData())
    }
    
    private func scrollReels(value: ScrollViewProxy) {
        if isScrollDown {
            var delay = 0.0
            for i in 1 ... Reels.totalCount {
                scrollReel(to: i * Reels.imagesPerReel - 1, delay: delay, value: value)
                delay += 0.05
            }
        } else {
            var delay = 0.0
            for i in 0 ..< Reels.totalCount {
                scrollReel(to: i * Reels.imagesPerReel, delay: delay, value: value)
                delay += 0.05
            }
        }
    }
    
    private func scrollReel(to position: Int, delay: Double, value: ScrollViewProxy) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation() {
                value.scrollTo(position)
            }
        }
    }

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                GeometryReader { geometry in
                    ScrollViewReader { value in
                        HStack(spacing: 10) {
                            ForEach(0 ..< Reels.totalCount) { index in
                                ReelView(reel: $reels[index], startIndex: index * Reels.imagesPerReel)
                            }
                        }
                        .padding(5)
                        .frame(height: geometry.size.width)
                        
                        Button("Spin") {
                            reels = model.fillReelsWithNewData(isScrollDown)
                            scrollReels(value: value)
                            isScrollDown.toggle()
                        }
                        
                    } // ScrollViewReader
                    
                } // GeometryReader
                
            } // VStack
            .padding(.top, 20)

        } // ZStack
        .navigationBarHidden(true)
        .statusBar(hidden: true)
    }
    
}

struct SlotMachineView_Previews: PreviewProvider {
    static var previews: some View {
        SlotMachineView()
    }
}
