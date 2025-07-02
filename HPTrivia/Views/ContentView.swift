//
//  ContentView.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 29/06/2025.
//

import SwiftUI
import AVKit //זה פלאגין שיאפשר להוסיף מוזיקה
//שיםלב שעשינו אנימציה בשני שיטות אחד זה פשוט ליצור משתנה לכל אנימציה ושתיים זה פשוט לעשות אנימציה על משתנה אחד שהגדרנו כמו לדוגמא פה עשינו לפעמים רק על אנימייט ויו
struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!//הוספנו משתנה לשימוש במוזיקה
    @State private var animateViewsIn = false //יצרנו משתנה כבוי לאנימצית תצוגה

    var body: some View {
        //גאו מתאים את האפליקציה לגודל המסך
        GeometryReader { geo in
            ZStack {
                AnimatedBackground(geo: geo)
                
                VStack {
                    //הוספנו את הרקע שהגדנו בקובץ גיימטייטל
                    //סימן דולר אומר למשתנה אנימייט שמגיע מקובץ גיימ להשתמש במשתנה המקור אנימייט מהקובץ כאן
                    GameTitle(animateViewsIn: $animateViewsIn)
                    
                    Spacer()
                    //הוספנו לוח נקודות
                    //כאן הדולר אומר למשתנה שמגיע מקובץ ריסנט להשתמש במשתנה אניממיט המקור
                    RecentScores(animateViewsIn: $animateViewsIn)
                    
                    Spacer()
                    //הדולר משתמש במשתנה המקור וגאו משתמש בגאו רידר
                    ButtonBar(animateViewsIn: $animateViewsIn, geo: geo)
                    
                    Spacer()
                }
                
            }
            //השורה הזו מתאימה את התצוגה לגודל המסך
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear { //כאן אנו מגדירים מה יקרה כשנפתח את האפליקציה
            //כאן הפעלנו את המשתנה על כל התצוגה
            animateViewsIn = true//כאן אנו מפעילים את משתנה האנימציה שהגדרנו למעלה
            //playAudio() //כאן הגדרנו להפעיל את הפונקציה להשמעת שיר
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
