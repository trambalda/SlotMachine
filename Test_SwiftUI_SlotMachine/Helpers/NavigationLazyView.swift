//
//  NavigationLazyView.swift
//  Test_SwiftUI_SlotMachine
//
//  Created by Денис Рубцов on 20.01.2022.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
