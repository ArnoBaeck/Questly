//
//  HomeTab.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI

struct HomeTab: View {
    var user: UserModel?

    var body: some View {
        VStack {
            if let user = user {
                Text("Welcome back, \(user.username)!")
                    .font(.title)
            } else {
                Text("Welcome!")
            }
        }
        .padding()
    }
}
