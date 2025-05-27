//
//  ContentRouter.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI

struct ContentRouter: View {
    @ObservedObject var controller: LoginController

    var body: some View {
        Group {
            if controller.isLoggedIn {
                MainView(controller: controller)
            } else {
                IndexView(controller: controller)
            }
        }
        .onAppear {
            controller.tryLogin()
        }
    }
}
