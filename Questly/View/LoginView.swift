//
//  LoginView.swift
//  Questly
//
//  Created by Arno Baeck on 26/05/2025.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject var controller: LoginController

    @State private var name = ""
    @State private var birthdate = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Your birthdate", text: $birthdate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Create Account") {
                controller.createUser(name: name, birthdate: birthdate)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
