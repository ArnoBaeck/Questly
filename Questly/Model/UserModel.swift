//
//  UserModel.swift
//  Questly
//
//  Created by Arno Baeck on 26/05/2025.
//

import Foundation

struct UserModel: Codable {
    var username: String
    var birthdate: String
    var preferences: [String]
}
