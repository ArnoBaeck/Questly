//
//  LocalStorage.swift
//  Questly
//
//  Created by Arno Baeck on 26/05/2025.
//

import Foundation

class LocalStorage {
    let userKey = "savedUser"

    func saveUser(user: UserModel) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }

    func getUser() -> UserModel? {
        if let data = UserDefaults.standard.data(forKey: userKey) {
            return try? JSONDecoder().decode(UserModel.self, from: data)
        }
        return nil
    }

    func clearUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
