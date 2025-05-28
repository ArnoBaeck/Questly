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
    @State private var birthdate: Date = Date()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Username", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Birthdate")
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal)

                    HStack {
                        DatePicker("", selection: $birthdate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(12)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .padding(.horizontal)
                }

                Button("Create account") {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    let formattedBirthdate = formatter.string(from: birthdate)

                    controller.createUser(name: name, birthdate: formattedBirthdate)
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
