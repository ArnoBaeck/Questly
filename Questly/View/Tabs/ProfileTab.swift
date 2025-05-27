//
//  ProfileTab.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI

struct ProfileTab: View {
    @ObservedObject var controller: LoginController

    var body: some View {
        VStack(spacing: 20) {
            if let user = controller.currentUser {
                Text("👤 \(user.username)")
                Text("🎂 \(user.birthdate)")
            }

            Button("Log out") {
                controller.logout()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
