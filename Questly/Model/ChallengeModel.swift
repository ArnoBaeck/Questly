//
//  ChallengeModel.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import MapKit

struct Challenge: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let reward: Int
    let deadline: String
    let location: String?
    let lat: Double
    let lon: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
