//
//  ContentView.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var coins = 16000
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                VStack {
                    HStack {
                        Text("888 Casino")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.leading)
                            .padding(.top, 72)
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(coins.formattedWithSeparator)")
                            .foregroundColor(.blue)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.leading, 70)
                        Image("coin")
                        Spacer()
                    }
                    .padding(.top, 4)
                    
                    Divider()
                        .padding(.top, 20)
                    
                    HStack {
                        Text("Play now")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top, 26)
                    
                    HStack(spacing: 84) {
                        NavigationLink(destination: SlotMachineView()) {
                            Image("egyptGameIcon1")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 110)
                        }.navigationBarHidden(true)
                        
                        Image("egyptGameIcon2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 110)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

