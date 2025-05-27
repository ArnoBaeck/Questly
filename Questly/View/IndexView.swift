//
//  IndexView.swift
//  Questly
//
//  Created by Arno Baeck on 08/04/2025.
//

import SwiftUI

struct IndexView: View {
    @ObservedObject var controller: LoginController
    
    @State private var currentIndex = 0
    @State private var previousIndex = 0
    @State private var currentOffset: CGFloat = -40
    @State private var previousOffset: CGFloat = 0
    @State private var showOpacity = false
    @State private var showRegisterSheet = false
    
    private let dynamicWords = ["mission", "reward"]
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image("Index_Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea() // Zorgt dat het beeld helemaal vult, ook achter notch

            VStack {
                VStack {
                    Image("Logo_Questly")
                }
                .padding(.top, 100)

                HStack(spacing: 0) {
                    Text("Q")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .bold()

                    Text("uestly")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .bold()
                }

                HStack(spacing: 6) {
                    Text("Your")
                        .font(.title)
                        .bold()

                    ZStack(alignment: .topLeading) {
                        Text(dynamicWords[previousIndex])
                            .font(.title)
                            .bold()
                            .offset(y: previousOffset.isNaN ? 0 : previousOffset)
                            .opacity(showOpacity ? 0 : 1)
                        Text(dynamicWords[currentIndex])
                            .font(.title)
                            .bold()
                            .offset(y: currentOffset.isNaN ? 0 : currentOffset)
                            .opacity(showOpacity ? 1 : 0)                    }
                    .frame(height: 40, alignment: .leading)
                    .clipped()
                }
                .onReceive(timer) { _ in
                    animateWordChange()
                }

                Spacer()

                VStack(spacing: 20) {
                    Button(action: {
                        controller.tryLogin()
                    }) {
                        Text("Login")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 0)
                    }

                    Button(action: {
                        showRegisterSheet = true
                    }) {
                        Text("Sign In")
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(100)
                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 0)
                    }
                    .sheet(isPresented: $showRegisterSheet) {
                        RegisterSheet(controller: controller, isPresented: $showRegisterSheet)
                    }                }
                .padding(.bottom, 50)
            }
            .padding()
        }
    }
    
    private func animateWordChange() {
        // Bereid animatie voor: reset waardes
        previousIndex = currentIndex
        currentIndex = (currentIndex + 1) % dynamicWords.count
        currentOffset = -40
        previousOffset = 0
        showOpacity = false
        
        // Start animatie
        withAnimation(.easeInOut(duration: 0.5)) {
            currentOffset = 0
            previousOffset = 40
            showOpacity = true
        }
    }
}

#Preview {
    IndexView(controller: LoginController())
}
