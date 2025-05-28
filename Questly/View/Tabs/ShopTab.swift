//
//  ShopTab.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI

struct ShopTab: View {
    @State private var items: [ShopItemModel] = []
    @EnvironmentObject var controller: LoginController
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Shop")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        if let coins = controller.currentUser?.coins {
                            Text("\(coins) coins")
                                .font(.subheadline)
                                .bold()
                                .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)

                    ForEach(items) { item in
                        NavigationLink(destination: ShopItemDetailView(item: item)) {
                            ShopItemCard(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .onAppear {
                fetchItems()
            }
            .background(Color.white.ignoresSafeArea())
        }
    }

    func fetchItems() {
        guard let url = URL(string: "https://raw.githubusercontent.com/ArnoBaeck/Questly/main/shop_items.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([ShopItemModel].self, from: data)
                    DispatchQueue.main.async {
                        self.items = decoded
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Fetch error:", error.localizedDescription)
            }
        }.resume()
    }
}

struct ShopItemCard: View {
    var item: ShopItemModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: item.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                } placeholder: {
                    Image("shop_placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                }

                Text("\(item.price) coins")
                    .font(.subheadline)
                    .bold()
                    .padding(6)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(8)
            }

            HStack {
                Text(item.title)
                    .bold()

                Spacer()

                Image(systemName: "chevron.right")
            }
            .padding(12)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
