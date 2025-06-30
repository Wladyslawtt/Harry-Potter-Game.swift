//
//  ContentView.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 29/06/2025.
//

import SwiftUI
import AVKit //זה פלאגין שיאפשר להוסיף מוזיקה

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!//הוספנו משתנה לשימוש במוזיקה
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
        .onAppear { //כאן אנו מגדירים מה יקרה כשנפתח את האפליקציה
            animateViewsIn = true//כאן אנו מפעילים את משתנה האנימציה שהגדרנו למעלה
            playAudio() //כאן הגדרנו להפעיל את הפונקציה להשמעת שיר
        }
    }
    
    private func playAudio() {//פונקציה לניגון מוזיקה
        //כאן הגדרנו מאיזה קובץ ומה השם שלו
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        //כאן הגדרנו את המשתנה שיצרנו למעלה שינסה ליצור נגן קול עם כותבת לקובץ מהנתיב
        //הסאונד עם סימן הקריאה הוא משתנה עם הנתיב לקובץ הקול
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        //זה אומר כמה פעמים אנו רוצים הוא יתנגן מינוס אחד אומר לנצח
        audioPlayer.numberOfLoops = -1
        //השורה מבצעת את הפונקציה
        audioPlayer.play()
        
    }
}

#Preview {
    ContentView()
}
