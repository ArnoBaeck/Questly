//
//  ShopItemDetailView.swift
//  Questly
//
//  Created by Arno Baeck on 28/05/2025.
//

import Foundation
import SwiftUI

struct ShopItemDetailView: View {
    let item: ShopItemModel
    @EnvironmentObject var controller: LoginController

    @State private var purchaseMessage: String?
    @State private var showMessage = false
    @State private var showCode = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image("shop_placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .clipped()

                if let coins = controller.currentUser?.coins {
                    Text("Balance: \(coins) coins")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Text(item.title)
                    .font(.title)
                    .bold()

                Text("Price: \(item.price) coins")
                    .bold()

                Spacer()

                Button(action: {
                    buyItem()
                }) {
                    Text("Buy item")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                if let message = purchaseMessage, showMessage {
                    Text(message)
                        .foregroundColor(message.contains("success") ? .green : .red)
                        .bold()
                        .transition(.opacity)
                }

                if showCode {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your gift code:")
                            .font(.headline)
                        Text(item.code)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .transition(.opacity)
                }
            }
            .padding()
        }
        .navigationTitle("Item details")
        .navigationBarTitleDisplayMode(.inline)
    }

    func buyItem() {
        guard let user = controller.currentUser else { return }

        if user.coins >= item.price {
            controller.subtractCoins(amount: item.price)
            purchaseMessage = "Purchase success!"
            showCode = true
        } else {
            purchaseMessage = "Not enough coins"
            showCode = false
        }

        withAnimation {
            showMessage = true
        }
    }
}
