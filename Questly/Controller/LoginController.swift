//
//  LoginController.swift
//  Questly
//
//  Created by Arno Baeck on 26/05/2025.
//

import Foundation

class LoginController: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentUser: UserModel?

    let storage = LocalStorage()

    func tryLogin() {
        if let saved = storage.getUser() {
            currentUser = saved
            isLoggedIn = true
            print("Gebruiker geladen: \(saved.username), \(saved.birthdate)")
        }
    }

    func createUser(name: String, birthdate: String) {
        let user = UserModel(username: name, birthdate: birthdate, preferences: [])
        storage.saveUser(user: user)
        currentUser = user
        isLoggedIn = true
        print("Gebruiker opgeslagen: \(user.username), \(user.birthdate)")
    }
    
    func logout() {
        storage.clearUser()
        currentUser = nil
        isLoggedIn = false
    }
    
    func addCoins(amount: Int) {
        guard var user = currentUser else { return }
        user.coins += amount
        currentUser = user
        storage.saveUser(user: user)
    }
    
    func subtractCoins(amount: Int) {
        guard var user = currentUser else { return }
        user.coins -= amount
        currentUser = user
        storage.saveUser(user: user)
    }
    
    func save() {
        if let user = currentUser {
            storage.saveUser(user: user)
        }
    }
}
