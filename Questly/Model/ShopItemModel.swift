//
//  ShopItemModel.swift
//  Questly
//
//  Created by Arno Baeck on 28/05/2025.
//

import Foundation

struct ShopItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let price: Int
    let image: String
    let provider: String
    let code: String
}
