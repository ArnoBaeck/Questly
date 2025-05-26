//
//  ProfileView.swift
//  Questly
//
//  Created by Arno Baeck on 26/05/2025.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var controller: LoginController

    var body: some View {
        VStack(spacing: 20) {
            if let user = controller.currentUser {
                Text("👤 Username: \(user.username)")
                    .font(.title2)

                Text("🎂 Birthdate: \(user.birthdate)")
                    .font(.subheadline)

            } else {
                Text("No user found")
            }

            Button("Log out") {
                controller.logout()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}
