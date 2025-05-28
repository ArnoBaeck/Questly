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

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: challenges) { challenge in
            MapMarker(coordinate: challenge.coordinate, tint: .red)
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            requestUserLocation()
            fetchChallenges()
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

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([Challenge].self, from: data)
                    DispatchQueue.main.async {
                        self.challenges = decoded
                        print("Challenges loaded: \(decoded.count)")
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
