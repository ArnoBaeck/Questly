//
//  RegisterSheet.swift
//  Questly
//
//  Created by Arno Baeck on 26/05/2025.
//

import Foundation
import SwiftUI

struct RegisterSheet: View {
    @ObservedObject var controller: LoginController
    @Binding var isPresented: Bool

    @State private var name: String = ""
    @State private var birthdate: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Username", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Birthdate (dd/mm/yyyy)", text: $birthdate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("Create account") {
                    controller.createUser(name: name, birthdate: birthdate)
                    isPresented = false
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("Create Account")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
