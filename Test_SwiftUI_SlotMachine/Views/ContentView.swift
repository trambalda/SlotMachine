//
//  ContentView.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int? = nil
    @State private var balance = 16000
    
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
                        Text("\(balance.formattedWithSeparator)")
                            .foregroundColor(.blue)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.leading, 70)
                        Image("coin_wo_border")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
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
                    
                    ZStack {
                        NavigationLink(destination: NavigationLazyView(SlotMachineView($balance)), tag: 1, selection: $selection) {
                            EmptyView() }.navigationBarHidden(true)
                        NavigationLink(destination: NavigationLazyView(SlotMachineView2()), tag: 2, selection: $selection) {
                            EmptyView() }.navigationBarHidden(true)
                        
                        HStack(spacing: 84) {
                            Button {
                                selection = 1
                            } label: {
                                Image("egyptGameIcon1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 110)
                            }
                            
                            Button {
                                selection = 2
                            } label: {
                                Image("egyptGameIcon2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 110)
                            }
                        }
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

struct SlotMachineView2: View {
    init() {
        print(#function, "SlotMachineView2")
    }
    
    var body: some View {
        Text("Hello")
    }
}

