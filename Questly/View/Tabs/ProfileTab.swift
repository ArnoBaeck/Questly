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

    @State private var username: String = ""
    @State private var email: String = ""
    @State private var birthdate: Date = Date()
    @State private var preferences: [String] = Array(repeating: "", count: 5)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Your personal information")
                    .font(.title3)
                    .bold()

                ProfileField(label: "Username", value: $username)
                ProfileField(label: "Email", value: $email)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Date of birth")
                        .font(.subheadline)
                        .bold()

                    HStack {
                        DatePicker("", selection: $birthdate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
                Text("Your personalized information")
                    .font(.title3)
                    .bold()

                ForEach(0..<5) { index in
                    ProfileField(label: preferenceLabels[safe: index] ?? "Preference \(index + 1)", value: $preferences[index])
                }

                Button("Log out") {
                    controller.logout()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            if let user = controller.currentUser {
                username = user.username
                email = user.email ?? ""
                birthdate = user.birthdate.toDate() ?? Date()

                let currentPrefs = user.preferences
                if currentPrefs.count < 5 {
                    preferences = currentPrefs + Array(repeating: "", count: 5 - currentPrefs.count)
                } else {
                    preferences = Array(currentPrefs.prefix(5))
                }
            }
        }
        .onDisappear {
            if controller.currentUser != nil {
                controller.currentUser?.username = username
                controller.currentUser?.email = email
                controller.currentUser?.birthdate = birthdate.toString()
                controller.currentUser?.preferences = preferences
                controller.save()
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct ProfileField: View {
    var label: String
    @Binding var value: String

    @State private var isEditing = false
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .bold()

            HStack {
                if isEditing {
                    TextField("", text: $value)
                        .focused($isFocused)
                        .onAppear { isFocused = true }
                } else {
                    Text(value)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }

                Spacer()

                Button(isEditing ? "save" : "change") {
                    isEditing.toggle()
                    if !isEditing {
                        hideKeyboard()
                    }
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(12)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }

    private func hideKeyboard() {
        isFocused = false
    }
}

let preferenceLabels = [
    "Favorite game genre",
    "Preferred challenge type",
    "Learning style",
    "Motivation trigger",
    "Best focus time"
]

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
