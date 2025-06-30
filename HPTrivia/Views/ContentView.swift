//
//  ContentView.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 29/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var animateViewsIn = false //יצרנו משתנה כבוי לאנימציה
    
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

                VStack {
                    VStack {//זה כדי שנוכל להוסיף תצוגה לכל מה שזה עוטף
                        if animateViewsIn { //אם האנימייט טרו אז לבצע
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .imageScale(.large)
                                    .font(.largeTitle)
                                
                                Text("HP")
                                    .font(.custom("PartyLetPlain", size: 70))
                                    .padding(.bottom, -50)
                                
                                Text("Trivia")
                                    .font(.custom("PartyLetPlain", size: 60))
                            }
                            .padding(.top, 70)
                            .transition(.move(edge: .top))
                        }//זה הסוג של האנימציה שאנו רוצים
                    }
                    .animation(.easeInOut(duration: 0.7).delay(2), value: animateViewsIn)//זו האנימציה עצמה
                    
                    Spacer()
                }
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear { //כאן אנו מפעילים את המשתנה שהגדרנו למעלה
                animateViewsIn = true
        }
    }
}

#Preview {
    ContentView()
}
