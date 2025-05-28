//
//  UserModel.swift
//  Questly
//
//  Created by Arno Baeck on 26/05/2025.
//

import Foundation

struct UserModel: Codable, Identifiable {
    let id = UUID()
    var username: String
    var birthdate: String
    var email: String?
    var preferences: [String]
    var coins: Int = 0

    init(username: String, birthdate: String, email: String? = nil, preferences: [String] = [], coins: Int = 0) {
        self.username = username
        self.birthdate = birthdate
        self.email = email
        self.preferences = preferences
        self.coins = coins
    }
}
