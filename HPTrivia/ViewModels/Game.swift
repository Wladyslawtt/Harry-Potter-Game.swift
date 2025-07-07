//
//  Game.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 03/07/2025.
//

import SwiftUI

//היא עוקבת אחר השינויים בתצוגה במשתנה או אובייקט מסויים
//היא מעדכנת את התצוגה בלייב כשנעשים שינויים בקוד
@Observable
//הגדרנו מחלקה בשם משחק שתנהל את כל הלוגיקה של המשחק
class Game {
    //הבאנו את הקובץ בוקקווס כדי שהמחלקה תוכל לנהל אותו
    //שים לב שגם בקובץ בוקקווס חייב להיות אובסרבל כדי שיהיה אפשר לשנות אותו
    var bookQuestions = BookQuestions()
    
    //הגדרנו שהניקוד יתחיל מאפס
    var gameScore = 0
    //הגדרנו ניקוד שיהיה על כל שאלה
    var questionScore = 5
    //הגדרנו את הנקודות האחרונות שיתחילו מאפס
    var recentScores = [0, 0, 0]
    
    //משתנה שמכיל את כל השאלות הפעילות כרגע בהתחלה ריק
    var activeQuestions: [Question] = []
    //משתנה שמכיל את כל השאלות שנענו כרגע בהתחלה ריק
    var answeredQuestions: [Int] = []
    // משתנה שמייצג את השאלה הנוכחית שהוצגה למשתמש
    var currentQuestion = try! JSONDecoder().decode([Question].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
    // מערך שמכיל את כל התשובות האפשריות או שנבחרו מתחיל כריק
    var answers: [String] = []
    //המערך משיג את תקיית הקבצים בטלפון כדי שיהיה אפשר לשמור בו את כל מה שהולך ביישום
    //הוא יוצר נתיב בשם רסנט סקורסט בתוך התקייות ולוקח את המערך הראשון בו ושומר שם את הקבצים
    let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "RecentScores")

    //פונקציית איתחול שאמורה לטעון נתונים מקבצי גייסון ואייפיאיי בעת פתיחת מופע חדש
    init() {
        //הוא טוען את הנקודות האחרונות שנשמרו ממשחק קודם
        loadScores()
    }
    
    //פונקצייה להתחיל משחק
    func startGame() {
        //עובר על כל הספרים בתוך האובייקט בוקקווסשן
        for book in bookQuestions.books {
            //בודק אם הספר פעיל
            if book.status == .active {
                //עובר על כל השאלות שיש באותו ספר
                for question in book.questions {
                    //מוסיף את כל השאלות למערך אקטיבקווסשן שהוא מאגד את כל השאלות שיהיו במשחק
                    activeQuestions.append(question)
                }
            }
        }
        //מתחיל את השאלה הבאה או הראשונה לפי הסיטואציה
        newQuestion()
    }
    
    //פונקצייה להופעת שאלה חדשה
    func newQuestion() {
        //אם כל השאלות כבר נשאלו מאלה שנמצאות באקטיבקוושן
        if answeredQuestions.count == activeQuestions.count {
            //מאפסים את הרשימה של השאלות שכבר נשאלו
            answeredQuestions = []
        }
        //שומרים במשתנה קורנטקווסשן שאלה אקראית מהשאלות הפעילות
        currentQuestion = activeQuestions.randomElement()!
        //כלעוד השאלה שבחרנו כבר נשאלה לפי איידי
        while(answeredQuestions.contains(currentQuestion.id)) {
            //ממשיכים לבחור שאלה אקראית חדשה
            currentQuestion = activeQuestions.randomElement()!
        }
        //מאפסים את רשימת התשובות
        answers = []
        //מוסיפים קודם את התשובה הנכונה
        answers.append(currentQuestion.answer)
        //עם כל תשובה מערך וורונג בשאלה הנוכחית
        for answer in currentQuestion.wrong {
            //יש להוסיף תשובה נוספת
            answers.append(answer)
        }
        //מערבבים את סדר התשובות
        answers.shuffle()
        //מאפסים את הניקוד לשאלות לחמש
        questionScore = 5
    }
    
    //פונקצייה להשלמת השאלה
    func correct() {
        //מוסיפים את האיידי של השאלה הנוכחית לרשימת שאלות שנענו
        //כדי שלא תשאל שוב בעתיד
        answeredQuestions.append(currentQuestion.id)
         //עם אנימציה
        withAnimation{
            //מעלה את הניקוד של השחקן לפי ניקוד השאלה
            gameScore += questionScore
        }
    }
    
    //פונקצייה לסיום המשחק
    func endGame() {
        //הציון שהיה במקום 1 עובר למקום 2
        recentScores[2] = recentScores[1]
        //הציון האחרון (מקום 0) עובר למקום 1
        recentScores[1] = recentScores[0]
        //הציון של המשחק הנוכחי נשמר בראש הרשימה (מקום 0)
        recentScores[0] = gameScore
        //אנחנו שומרים את הנקודות עם הפונקציה שיצרנו
        saveScore()
        //מאפס את הציון של המשחק
        gameScore = 0
        //מנקה את כל השאלות שהיו במשחק – איפוס לפני משחק חדש
        activeQuestions = []
        //מאפס את רשימת השאלות שנענו
        answeredQuestions = []
    }
    
    //יצרנו פונקציה שאמורה לשמור את הנקודות שלנו
    func saveScore() {
        do {
            //הוא לוקח את הנקודות והופך אותן לגייסון
            let data = try JSONEncoder().encode(recentScores)
            //הוא שומר את הגייסון בתקיית קבצים שיצרנו עם המערך סייב פת למעלה
            try data.write(to: savePath)
        } catch {
            print("Unable to save data: \(error)")
        }
    }
    
    //יצרנו פונקציה שאמורה לטעון את הנקודות ששמרנו למסך הראשי בחזרה כשאנו פותחים את האפליקציה
    func loadScores() {
        do {
            //יש לטעון את הדאטה מהדאטה של הקבצים ששמרנו מקודם
            let data = try Data(contentsOf: savePath)
            //יש לפאנח את הדאטה שהוצאנו מהדאטה שנטען
            recentScores = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            //הגדרנו נקודות אפס כי יכול להות להיישום נפתח פעם ראשונה ואין מה לטעון
            recentScores = [0, 0, 0]
        }
    }
    
    //פונקציית איתחול שאמורה לטעון נתונים מקבצי גייסון ואייפיאיי בעת פתיחת מופע חדש
//    init() {
        //4//השורה טוענת את השאלה הראשונה בקובץ טריויה בגייסון
        //3//המפאנח גייסון ממיר את הדאטה למערך אובייקטים מסוג קווסשן
        //2//הדאטה טוען את תוכן הקובץ כאובייקט דאטה
        //1//הדאטה מחפש קובץ טריויה גייסון בתוך הבאנדל הראשי ומחזיר את הכתובת שלו
//        currentQuestion = try! JSONDecoder().decode([Question].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
//    } //הוספנו אותו לקוד למעלה אבל אפשר גם לעשות אותו באיניט
    
}




//גייסון דיקודר לוקח גייסון מוכן והופך אותו למידע שאפשר להשתמש בו בתוכנה
//גייסון אנקודר לוקח את המידע המשומש בתוכנה והופך אותו לגייסון
