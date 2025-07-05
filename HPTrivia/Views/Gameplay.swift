//
//  Gameplay.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 04/07/2025.
//

import SwiftUI
import AVKit

struct Gameplay: View {
    //הבאנו אובייקט גיימ מתוך הסביבה הראשית ואיחסנו במשתנה גיימ
    @Environment(Game.self) private var game
    //הבאנו אובייקט ביטול מתוך הסביבה הראשית לאיחרנו במשתנה דיסמיס
    //הוא מיועד לתת לנו אפשרות לסגור את המופע או המסך
    @Environment(\.dismiss) private var dismiss
    
    //יבאנו משתנה לניגון מוזיקה במסך הזה
    @State private var musicPlayer: AVAudioPlayer!
    //יבאנו משתנה לניגון קולות רקע
    @State private var sfxPlayer: AVAudioPlayer!
    
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
        //ברגע ההופעה יש לנגן מוסיקה
        .onAppear{
            //הגדרנו התחלת משחק ברגע ההופעה
            game.startGame()
            //הגדרנו שהמוזיקה תתנגן באיחור של שתי שניות מעכשיו
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //            playMusic()
            }
        }
    }
    
    
    private func playMusic() {//פונקציה לניגון מוזיקה
        //הגדרנו מערך עם כל המוסיקה שאנו רוצים שיהיה
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
        //הגדרנו שינגן מוסיקה רנדומלית מהעמרך שהגדרנו למעלה
        let song = songs.randomElement()!
        //כאן הגדרנו מאיזה קובץ ומה השם שלו
        let sound = Bundle.main.path(forResource: song, ofType: "mp3")
        //כאן הגדרנו את המשתנה שיצרנו למעלה שינסה ליצור נגן קול עם כותבת לקובץ מהנתיב
        //הסאונד עם סימן הקריאה הוא משתנה עם הנתיב לקובץ הקול
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        //זה אומר כמה פעמים אנו רוצים הוא יתנגן מינוס אחד אומר לנצח
        musicPlayer.numberOfLoops = -1
        //הגדרנו ווליום למוסיקה
        musicPlayer.volume = 0.1
        //השורה מבצעת את הפונקציה
        musicPlayer.play()
        
    }
    //אלה הקולות רקע עם אפקטים
    private func playFlipSound() {//פונקציה לניגון מוזיקה
        //כאן הגדרנו מאיזה קובץ ומה השם שלו
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        //כאן הגדרנו את המשתנה שיצרנו למעלה שינסה ליצור נגן קול עם כותבת לקובץ מהנתיב
        //הסאונד עם סימן הקריאה הוא משתנה עם הנתיב לקובץ הקול
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        //השורה מבצעת את הפונקציה
        sfxPlayer.play()
        //הקול רקע יתנגן פעל אחת כי אין לו לופסּ
    }
    private func playWrongSound() {//פונקציה לניגון מוזיקה
        //כאן הגדרנו מאיזה קובץ ומה השם שלו
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        //כאן הגדרנו את המשתנה שיצרנו למעלה שינסה ליצור נגן קול עם כותבת לקובץ מהנתיב
        //הסאונד עם סימן הקריאה הוא משתנה עם הנתיב לקובץ הקול
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        //השורה מבצעת את הפונקציה
        sfxPlayer.play()
        //הקול רקע יתנגן פעל אחת כי אין לו לופסּ
    }
    private func playCorrectSound() {//פונקציה לניגון מוזיקה
        //כאן הגדרנו מאיזה קובץ ומה השם שלו
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        //כאן הגדרנו את המשתנה שיצרנו למעלה שינסה ליצור נגן קול עם כותבת לקובץ מהנתיב
        //הסאונד עם סימן הקריאה הוא משתנה עם הנתיב לקובץ הקול
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        //השורה מבצעת את הפונקציה
        sfxPlayer.play()
        //הקול רקע יתנגן פעל אחת כי אין לו לופסּ
        //אנחנו משתמים באותו שם ספקס פלייר לכל שלושתם כי אלה הם הולכים להשמע רק פעם אחת אז אין סיבה לשנות שמות אצלהם
    }
}

#Preview {
    Gameplay()
        .environment(Game()) //קישרנו אותו לסביבת המשחק
}
