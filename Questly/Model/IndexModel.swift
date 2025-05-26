//
//  IndexModel.swift
//  Questly
//
//  Created by Arno Baeck on 08/04/2025.
//

import Foundation

class IndexModel: ObservableObject {
    let loginController = LoginController()

    func login() {
        loginController.tryLogin()
    }

    func signIn() {
        loginController.createUser(name: "John Doe", birthdate: "01/01/2000")
    }
}
