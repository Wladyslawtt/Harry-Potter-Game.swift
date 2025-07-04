//
//  Gameplay.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 04/07/2025.
//

import SwiftUI

struct Gameplay: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.8))
                    }
                
                VStack {
                    // MARK: Controls
                    
                    // MARK: Question
                    
                    //MARK: Hints
                    
                    // MARK: Answers
                }
                //מישר את התצוגה לפי המסך עם הגאו רידר
                .frame(width: geo.size.width, height: geo.size.height)
                
                // MARK: Celebration Screen
            }
            //מישר את התצוגה לפי המסך עם הגאו רידר
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Gameplay()
}
