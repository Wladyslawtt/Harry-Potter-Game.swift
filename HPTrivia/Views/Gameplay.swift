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
    
    //הגדרנו משתנה אנימציה כבוי
    @State private var animateViewsIn = false
    //הגדרנו משתנה שיראה לנו רמז כרגע הוא כבוי
    @State private var revealHint = false
    //הגדרנו משתנה שיראה לנו את הספר כרגע הוא כבוי
    @State private var revealBook = false
    //הגדרנו משתנה שידע מתי לחצנו על התשובה הנכונה כרגע הוא כבוי
    @State private var tappedCorrectAnswer = false
    
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
                    HStack {
                        //כפתור לסיום המשחק
                        Button("End Game") {
                            game.endGame()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        //הנקודות במשחק
                        Text("Score: \(game.gameScore)")
                    }
                    .padding()
                    .padding(.vertical, 30)
                    
                    // MARK: Question
                    VStack {
                        //אם האנימציה פעילה
                        if animateViewsIn {
                            Text(game.currentQuestion.question)
                                .font(.custom("PartyLetPlain", size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                                .transition(.scale)
                        }
                    }
                    //האנימציה עצמה
                    .animation(.easeInOut(duration: 2), value: animateViewsIn)
                    
                    Spacer()
                       
                    
                    // MARK: Hints
                    HStack{
                        VStack {
                            //הגדרנו אופציה לרמז
                            if animateViewsIn {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .padding()
                                //מיצב את המסך לפי הגודל שלו
                                    .transition(.offset(x: -geo.size.width/2))
                                //הגדרנו אנימציה מתגלגלת
                                    .phaseAnimator([false,true]) { content,phase in
                                        content
                                        //אם נכון הפייס יהיה מינוס אם לא נכון יהיה פלוס
                                            .rotationEffect(.degrees(phase ? -13 : -17))
                                        //זה הופך את האנימציה ליותר חלקה
                                    } animation: { _ in
                                            .easeInOut(duration: 0.7)
                                    }
                                //מראה בלחיצה רמז
                                    .onTapGesture {
                                        //צריך לשים וויז כדי שהאנימציה תפעל
                                        //עם האנימציה הרמז מופעל
                                        withAnimation(.easeInOut(duration: 1)) {
                                            revealHint = true
                                        }
                                        //מפעיל מוזיקה בלחיצה
                                        playFlipSound()
                                        //זה יוריד נקודה כל פעם כשמשתמשים ברמז
                                        game.questionScore -= 1
                                    }
                                //הגדרנו היפוך תלת מימד עם הופעת רמז
                                //אם הרמז טרו הוא יתהפך אלף פעם אם פולס אז לא יתהפך
                                    .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                //האניצמיה בנויה על רווילהינט
                                //הגדרנו אפקט סקייל אם כן אז חמש אם לא אז רחד
                                    .scaleEffect(revealHint ? 5 : 1)
                                //הגדרנו גודל אם כן אז להתאים אם גאו אם לא אז אפס
                                    .offset(x: revealHint ? geo.size.width/2 : 0)
                                //הגדרנו אופסיטי אם כן אז להיעלם אם לא אז תשאיר
                                    .opacity(revealHint ? 0 : 1)
                                    .overlay {
                                        Text(game.currentQuestion.hint)
                                            .padding(.leading, 20)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                        //הגדרנו אופסיטי אם כן אז להופיע אם לא אז להעלים
                                            .opacity(revealHint ? 1 : 0)
                                            .scaleEffect(revealHint ? 1.33 : 1)
                                    }
                            }
                        }
                        //זו האנימציה שעוטפת את כל הרמז
                        .animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)
                        
                        Spacer()
                        
                        VStack {
                            //הגדרנו אופציה להופעת הספרים
                            if animateViewsIn {
                                Image(systemName: "app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .overlay {
                                        Image(systemName: "book.closed")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                            .foregroundStyle(.black)
                                    }
                                    .padding()
                                //מיצב את המסך לפי הגודל שלו
                                    .transition(.offset(x: geo.size.width/2))
                                //הגדרנו אנימציה מתגלגלת
                                    .phaseAnimator([false,true]) { content,phase in
                                        content
                                        //אם נכון הפייס יהיה מינוס אם לא נכון יהיה פלוס
                                            .rotationEffect(.degrees(phase ? 13 : 17))
                                        //זה הופך את האנימציה ליותר חלקה
                                    } animation: { _ in
                                            .easeInOut(duration: 0.7)
                                    }
                                //מראה בלחיצה ספר
                                    .onTapGesture {
                                        //צריך לשים וויז כדי שהאנימציה תפעל
                                        //עם האנימציה הספר מופעל
                                        withAnimation(.easeInOut(duration: 1)) {
                                            revealBook = true
                                        }
                                        //מפעיל מוזיקה בלחיצה
                                        playFlipSound()
                                        //זה יוריד נקודה כל פעם כשמשתמשים ברמז
                                        game.questionScore -= 1
                                    }
                                //הגדרנו היפוך תלת מימד עם הופעת ספר
                                //אם הרמז טרו הוא יתהפך אלף פעם אם פולס אז לא יתהפך
                                    .rotation3DEffect(.degrees(revealBook ? -1440 : 0), axis: (x: 0, y: 1, z: 0))
                                //האניצמיה בנויה על רווילהינט
                                //הגדרנו אפקט סקייל אם כן אז חמש אם לא אז רחד
                                    .scaleEffect(revealBook ? 5 : 1)
                                //הגדרנו גודל אם כן אז להתאים אם גאו אם לא אז אפס
                                    .offset(x: revealBook ? -geo.size.width/2 : 0)
                                //הגדרנו אופסיטי אם כן אז להיעלם אם לא אז תשאיר
                                    .opacity(revealBook ? 0 : 1)
                                    .overlay {
                                        Image("hp\(game.currentQuestion.book)")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(.trailing, 20)
                                        //הגדרנו אופסיטי אם כן אז להופיע אם לא אז להעלים
                                            .opacity(revealBook ? 1 : 0)
                                            .scaleEffect(revealBook ? 1.33 : 1)
                                    }
                            }
                        }
                        //זו האנימציה שעוטפת את כל הספר
                        .animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)
                        
                    }
                    .padding()
                    
                    // MARK: Answers
                    //הגדרנו רשת עם שתי עמודות
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        //תצוגה של כל התשובות לפי איידי
                        ForEach(game.answers, id: \.self) { answer in
                            //אם התשובה שווה לשאלה הנוכחית לתשובה אז
                            if answer == game.currentQuestion.answer {
                                VStack {
                                    //אנימציה לכפתור אם הוא פעיל
                                    if animateViewsIn {
                                        //להפעיל את הכפתור של התשובה הנכונה
                                        Button {
                                            tappedCorrectAnswer = true
                                            
                                            playCorrectSound()
                                            
                                            game.correct()
                                        } label: {
                                            Text(answer)
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.center)
                                                .padding(10)
                                                .frame(width: geo.size.width/2.15, height: 80)
                                                .background(.green.opacity(0.5))
                                                .clipShape(.rect(cornerRadius: 20))
                                        }
                                        //אנימציה לכפתור
                                        .transition(.scale)
                                    }
                                }
                                //אנימציה לכל המערך של הפתור הנכון
                                .animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                            } else {
                                //מגדירים כפתור לתשובות לא נכונות
                                VStack {
                                    //אנימציה לכפתור אם הוא פעיל
                                    if animateViewsIn {
                                        //להפעיל את הכפתור של התשובה לא נכונה
                                        Button {
                                            playWrongSound()
                                            //מוריד ניקוד בעת הנקישה
                                            game.questionScore -= 1
                                        } label: {
                                            Text(answer)
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.center)
                                                .padding(10)
                                                .frame(width: geo.size.width/2.15, height: 80)
                                                .background(.green.opacity(0.5))
                                                .clipShape(.rect(cornerRadius: 20))
                                        }
                                        //אנימציה לכפתור
                                        .transition(.scale)
                                    }
                                }
                                //אנימציה לכל המערך של הפתור הלא נכון
                                .animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                            }
                        }
                    }
                    
                    
                    Spacer()
                }
                //מישר את התצוגה לפי המסך עם הגאו רידר
                .frame(width: geo.size.width, height: geo.size.height)
                
                // MARK: Celebration Screen
            }
            //מישר את התצוגה לפי המסך עם הגאו רידר
            .frame(width: geo.size.width, height: geo.size.height)
            .foregroundStyle(.white)
        }
        .ignoresSafeArea()
        //ברגע ההופעה יש לנגן מוסיקה
        .onAppear{
            //הגדרנו התחלת משחק ברגע ההופעה
            game.startGame()
            //הגדרנו שהאנימציה תבוא באיחור של כמה שניות מעכשיו
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //הפעלנו את האנימציה
                animateViewsIn = true
            }
            //הגדרנו שהמוזיקה תתנגן באיחור של שתי שניות מעכשיו
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                playMusic()
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
