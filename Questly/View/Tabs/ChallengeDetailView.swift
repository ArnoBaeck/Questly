//
//  ChallengeDetailView.swift
//  Questly
//
//  Created by Arno Baeck on 28/05/2025.
//

import Foundation
import SwiftUI
import MapKit

struct ChallengeDetailView: View {
    let challenge: Challenge
    @EnvironmentObject var controller: LoginController
    @State private var showCompletedMessage = false
    @State private var isAccepted = false
    @State private var isCompleted = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                HStack {
                    Text("Deadline: \(challenge.deadline)")
                        .font(.subheadline)
                    Spacer()
                    Text("Reward: \(challenge.reward) coins")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.black)
                }

                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: challenge.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )), annotationItems: [challenge]) { _ in
                    MapAnnotation(coordinate: challenge.coordinate) {
                        Image(systemName: "flag.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
                .frame(height: 200)
                .cornerRadius(12)

                Text(challenge.title)
                    .font(.title)
                    .bold()

                if let location = challenge.location {
                    Text(location)
                        .foregroundColor(.gray)
                }

                Text("What to do")
                    .font(.headline)
                Text(challenge.description)

                if isCompleted {
                    Text("Challenge completed")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                } else if isAccepted {
                    Button(action: {
                        cancelChallenge()
                    }) {
                        Text("Cancel quest")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: {
                        acceptChallenge()
                    }) {
                        Text("Accept quest")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(isAccepted || isCompleted)
                }

                if showCompletedMessage {
                    VStack(spacing: 8) {
                        Text("Challenge completed!")
                            .font(.headline)
                            .foregroundColor(.green)
                        Text("You earned \(challenge.reward) coins")
                    }
                    .transition(.opacity)
                }
            }
            .padding()
        }
        .navigationTitle("Quest details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadStatus()
        }
    }

    func acceptChallenge() {
        guard !isAccepted && !isCompleted else { return }

        isAccepted = true
        showCompletedMessage = false
        saveStatus()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            controller.addCoins(amount: challenge.reward)
            withAnimation {
                isCompleted = true
                showCompletedMessage = true
                saveStatus()
            }
        }
    }

    func cancelChallenge() {
        isAccepted = false
        isCompleted = false
        showCompletedMessage = false
        saveStatus()
    }

    func statusKey(_ key: String) -> String {
        return "challenge.\(challenge.id).\(key)"
    }

    func saveStatus() {
        UserDefaults.standard.set(isAccepted, forKey: statusKey("accepted"))
        UserDefaults.standard.set(isCompleted, forKey: statusKey("completed"))
    }

    func loadStatus() {
        isAccepted = UserDefaults.standard.bool(forKey: statusKey("accepted"))
        isCompleted = UserDefaults.standard.bool(forKey: statusKey("completed"))
    }
}
