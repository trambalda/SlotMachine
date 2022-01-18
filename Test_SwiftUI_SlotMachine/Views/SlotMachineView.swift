//
//  SlotMachineView.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 19.01.2022.
//

import SwiftUI

struct SlotMachineView: View {
    var body: some View {
        ZStack {
            Color.gray
            VStack {
                Text("test")
            }
        }
        .navigationBarHidden(true)
    }
}

struct SlotMachineView_Previews: PreviewProvider {
    static var previews: some View {
        SlotMachineView()
    }
}
