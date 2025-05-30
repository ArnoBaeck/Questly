//
//  QuestlyApp.swift
//  Questly
//
//  Created by Arno Baeck on 08/04/2025.
//

import SwiftUI

@main
struct QuestlyApp: App {
    @StateObject var controller = LoginController()

    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some Scene {
        WindowGroup {
            ContentRouter(controller: controller)
        }
    }
}
