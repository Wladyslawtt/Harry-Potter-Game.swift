//
//  ContentView.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 29/06/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //גאו מתאים את האפליקציה לגודל המסך
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .offset(x: phase ? geo.size.width/1.1 : -geo.size.width/1.1)
                    } animation: { _ in
                            .linear(duration: 60)
                    }//פייס זו האניצמייית תזוזה של הרקע

            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
