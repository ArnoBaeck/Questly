//
//  MainView.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI

struct MainView: View {
    @ObservedObject var controller: LoginController

    var body: some View {
        TabView {
            HomeTab(user: controller.currentUser)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ChallengesTab()
                .tabItem {
                    Label("Challenges", systemImage: "flag.checkered")
                }

            ShopTab()
                .tabItem {
                    Label("Shop", systemImage: "cart")
                }

            ProfileTab(controller: controller)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}
