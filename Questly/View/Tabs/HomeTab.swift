//
//  HomeTab.swift
//  Questly
//
//  Created by Arno Baeck on 27/05/2025.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct HomeTab: View {
    var user: UserModel?

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer().frame(height: 16)

                MapView()
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}
