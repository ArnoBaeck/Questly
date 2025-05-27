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
    struct MapPin: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

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

    let pins: [MapPin] = [
        MapPin(coordinate: CLLocationCoordinate2D(latitude: 50.8606, longitude: 4.3517)),
        MapPin(coordinate: CLLocationCoordinate2D(latitude: 50.8500, longitude: 4.3425))
    ]

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: pins) { pin in
            MapMarker(coordinate: pin.coordinate, tint: .red)
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            requestUserLocation()
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
}
