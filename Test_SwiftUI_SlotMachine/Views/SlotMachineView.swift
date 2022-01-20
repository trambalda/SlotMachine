//
//  SlotMachineView.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import SwiftUI

struct SlotMachineView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isScrollDown = true
    @State private var reels: [[Int]]
    private let model = SlotMachineModel()
    
    @Binding private var balance: Int
    
    private let betStep = 25
    @State private var localBalance: Int
    @State private var bet = 25
    @State private var profit = 0
    @State private var isGameOver = false
    @State private var isShowWin = false
    @State private var win = 0

    init(_ balance: Binding<Int>) {
        _reels = State(initialValue: model.fillReelsWithNewData())
        _balance = balance
        _localBalance = State(initialValue: balance.wrappedValue)
    }
    
    // MARK: - GAME LOGIC
    
    private func changeBet(isIncrease: Bool) {
        bet = isIncrease ? bet + betStep : bet - betStep
        if bet > localBalance { bet = localBalance }
        if bet < 25 { bet = 25 }
    }
    
    private func makeBet() {
        localBalance -= bet
    }
    
    private func checkWin() {
        let i = isScrollDown ? 0 : Reels.imagesPerReel - 3
        if reels[0][i] == reels[1][i] && reels[1][i] == reels[2][i] ||
            reels[0][i+1] == reels[1][i+1] && reels[1][i+1] == reels[2][i+1] ||
            reels[0][i+2] == reels[1][i+2] && reels[1][i+2] == reels[2][i+2] {
            win = bet * 10
            localBalance += win
            profit += win
            isShowWin = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isShowWin = false
            }
        } else {
            checkCanContinueGame()
        }
    }
    
    private func checkCanContinueGame() {
        isGameOver = localBalance < bet
    }
    
    // MARK: - SLOT ANIMATION
    
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
    
    // MARK: - ADJUST SPACING & PADDING FOR SMALL AND NORMAL SCREENS
    
    private func calculateHeight(width: CGFloat) -> CGFloat {
        return 3 * width / CGFloat(Reels.totalCount)
    }
    
    private func calculatePadding(width: CGFloat) -> CGFloat {
        return width < 400 ? 40 : 10
    }

    private func calculateInvertedPadding(width: CGFloat) -> CGFloat {
        return width < 400 ? 10 : 40
    }

    // MARK: - BODY

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            
            GeometryReader { geometry in
                VStack() {
                    
                    // MARK: - SLOT MACHINE
                    
                    ScrollViewReader { value in
                        VStack {
                            ZStack {
                                HStack() {
                                    ForEach(0 ..< Reels.totalCount) { index in
                                        ReelView(reel: $reels[index], startIndex: index * Reels.imagesPerReel)
                                    }
                                }
                                .padding(calculatePadding(width: geometry.size.width))
                                .frame(height: self.calculateHeight(width: geometry.size.width))
                                
                                HStack() {
                                    Text("WIN: \(win.formattedWithSeparator)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Image("coin_wo_border")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                } // HStack
                                .shadow(color: .black, radius: 1, x: 0, y: 0)
                                .padding(50)
                                .background(Color(Color.RGBColorSpace.sRGB, red: 0, green: 0, blue: 0, opacity: 0.8))
                                .cornerRadius(10)
                                .opacity(isShowWin ? 1 : 0)
                            } // ZStack
                            
                            // MARK: - BALANCE INFO
                            
                            HStack() {
                                Text("BALANCE: \(localBalance.formattedWithSeparator)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Image("coin_wo_border")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                            } // HStack
                            .shadow(color: .black, radius: 1, x: 0, y: 0)
                            .padding(.top, -calculatePadding(width: geometry.size.width))
                        } // VStack
                        
                        // MARK: - SPIN BUTTON
                        
                        Button {
                            makeBet()
                            reels = model.fillReelsWithNewData(isScrollDown)
                            scrollReels(value: value)
                            isScrollDown.toggle()
                            checkWin()
                        } label: {
                            ZStack {
                                Image("spinButton")
                                    .resizable()
                                    .scaledToFit()
                                Text("SPIN")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(Color.RGBColorSpace.sRGB, red: 0x36/255, green: 0xb1/255, blue: 0, opacity: 1))
                            }
                            .background(
                                Circle()
                                    .foregroundColor(Color(Color.RGBColorSpace.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4))
                            )
                            .shadow(color: .black, radius: 1, x: 0, y: 0)
                            .frame(width: 100, height: 100)
                            .padding(.bottom, calculateInvertedPadding(width: geometry.size.width))
                            .opacity(isGameOver ? 0.5 : 1)
                        }
                        .disabled(isGameOver || isShowWin)
                        
                    } // ScrollViewReader
                    
                    
                    // MARK: - CHANGE BET CONTROLS
                    
                    HStack {
                        Button {
                            changeBet(isIncrease: false)
                        } label: {
                            Text("-")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }.padding()
                        VStack {
                            Text("CURRENT BET")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            HStack {
                                Text("\(bet.formattedWithSeparator)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Image("coin_wo_border")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                        }
                        Button {
                            changeBet(isIncrease: true)
                        } label: {
                            Text("+")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }.padding()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .background(Color(Color.RGBColorSpace.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4))
                    .cornerRadius(10)
                    
                    // MARK: - EXIT BUTTON & WIN INFO
                    
                    HStack(spacing: 40) {
                        Button {
                            balance = localBalance
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("EXIT")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 160, height: 70)
                        }
                        .background(Color(Color.RGBColorSpace.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4))
                        .cornerRadius(10)
                        
                        VStack(spacing: 0) {
                            Text("TOTAL WIN")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            HStack {
                                Text("\(profit.formattedWithSeparator)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Image("coin_wo_border")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                        }
                        .frame(width: 160, height: 70)
                        .background(Color(Color.RGBColorSpace.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4))
                        .cornerRadius(10)
                    }
                    
                } // VStack
                .padding(.top, -calculatePadding(width: geometry.size.width) + 10)
                
            } // GeometryReader
            
        } // ZStack
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .onAppear {
            checkCanContinueGame()
        }
    }
    
}

struct SlotMachineView_Previews: PreviewProvider {
    static var previews: some View {
        SlotMachineView(.constant(16000))
    }
}
