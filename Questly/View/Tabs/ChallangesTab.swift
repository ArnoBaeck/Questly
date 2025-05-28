//
//  Challanges.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI
import MapKit

struct ChallengesTab: View {
    @State private var challenges: [Challenge] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("All quests")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)

                    ForEach(challenges) { challenge in
                        NavigationLink(destination: ChallengeDetailView(challenge: challenge)) {
                            ChallengeCard(challenge: challenge)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .onAppear {
                fetchChallenges()
            }
            .background(Color.white.ignoresSafeArea())
        }
    }

    func fetchChallenges() {
        guard let url = URL(string: "https://raw.githubusercontent.com/ArnoBaeck/Questly/refs/heads/main/challenges.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([Challenge].self, from: data)
                    DispatchQueue.main.async {
                        self.challenges = decoded
                    }
                } catch {
                    print("Error decoding:", error)
                }
            } else if let error = error {
                print("error loading:", error.localizedDescription)
            }
        }.resume()
    }
}

struct ChallengeCard: View {
    var challenge: Challenge

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: challenge.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    )
                ), annotationItems: [challenge]) { _ in
                    MapAnnotation(coordinate: challenge.coordinate) {
                        Image(systemName: "flag.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
                .frame(height: 150)
                .cornerRadius(20)
                .disabled(true)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                )

                Text("\(challenge.reward) coins")
                    .font(.subheadline)
                    .bold()
                    .padding(6)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(8)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text(challenge.title)
                        .bold()
                    Text(challenge.location ?? "Brussel")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }

                Spacer()

                Image(systemName: "chevron.right")
            }
            .padding([.horizontal, .bottom], 12)
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
