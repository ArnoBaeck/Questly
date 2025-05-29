//
//  MapView.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.8503, longitude: 4.3517),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var userLocation: CLLocationCoordinate2D? {
        didSet {
            if let location = userLocation {
                region.center = location
            }
        }
    }

    @State private var challenges: [Challenge] = []
    @State private var selectedChallengeID: String?

    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: challenges) { challenge in
                MapAnnotation(coordinate: challenge.coordinate) {
                    VStack(spacing: 8) {
                        Button(action: {
                            withAnimation {
                                if selectedChallengeID == challenge.id {
                                    selectedChallengeID = nil
                                } else {
                                    selectedChallengeID = challenge.id
                                }
                            }
                        }) {
                            Image(systemName: "flag.circle.fill")
                                .resizable()
                                .frame(width: 34, height: 34)
                                .foregroundColor(.blue)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }

                        if selectedChallengeID == challenge.id {
                            VStack(spacing: 6) {
                                Text(challenge.description)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .padding(6)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)

                                NavigationLink(destination: ChallengeDetailView(challenge: challenge)) {
                                    Text("More info")
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(6)
                                }
                            }
                            .frame(maxWidth: 180)
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                requestUserLocation()
                fetchChallenges()
            }
        }
    }

    func requestUserLocation() {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let location = manager.location?.coordinate {
                userLocation = location
            }
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
                    print("Decode error: \(error)")
                }
            } else if let error = error {
                print("Fetch error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
