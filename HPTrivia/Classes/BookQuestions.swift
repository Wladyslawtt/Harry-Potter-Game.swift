//
//  BookQuestions.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import Foundation

@Observable //זו מחלקה שאפשר לעקוב אחרי השינויים בה
class BookQuestions { //הגדרנו מחלקה של שאלות מספרים
    var books: [Book] = [] //זה מערך של כל הספרים כברירת מחדל היא הוגדרה כריקה
    
    //הקוד איניט מוגדר למחלקה ומבצע שלוש שלבים
    //הוא מתאפס כל פעם ומפעיל את כל הפעולות מחד כשיוצרים מופע חדש
    init() {
        //מפאנח את כל השאלות מקובץ גייסון
        let decodedQuestions = decodeQuestions()
        //מארגן את כל השאלות לקבוצות לפי ספרים
        let organizeQuestions = organizeQuestions(decodedQuestions)
        //יוצר את רשימת הספרים עם השאלות מסודרות
        populatedBooks(with: organizeQuestions)
    }
    
    //הגדרנו פונקצייה שתפאנח את השאלות מקובץ גייסון
    //וגם שתחזיר מערך של כל השאלות
    private func decodeQuestions() -> [Question]{
        //הגדרנו מערך של כל השאלות שפואנחו וכברירת מחדל היא הוגדרה כריקה
        var decodedQuestions: [Question] = []
        //הגדרנו שאם הוא ינסה לאתר את הקובץ טריויה מסוג גיסון בחבילת האפליקציה אז
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json") {
            do {
                //מנסה לקרוא את התוכן דאטה מהיוראל ולשמור במערך דאטה
                let data = try Data(contentsOf: url)
                //הגדרנו שהמערך דיקודד קווסטיון ינסה לפאנח את כל השאלות מהדאטה
                decodedQuestions = try JSONDecoder().decode([Question].self, from: data)
            } catch {  // מדפיס שגיאה אם הפענוח נכשל
                print("Error decoding JSON data: \(error)")
            }
        }
        //ויחזיר בסוף את כל מה שפואנח
        return decodedQuestions
    }
    
    //הגדרנו פונקציה שתסדר את השאלות לפי הספרים שלה ושתחזיר את את השאלות מסודרות בקבוצות לפי הספרים
    private func organizeQuestions(_ questions: [Question]) -> [[Question]] {
        //הגדרנו מערך של סידור הקבוצות וכברירת מחדל הן ריקות בהתחלה
        //שמנו שמונה משבצות כי הקבוצות יפואנחו לפי הסדר ובמחשב זה מתחיל מאפס אז קבוצה ראשונה תיהיה ריקה והסידור יתחיל מהמספר הראשון בקבוצה כאילו המשבצת השניה
        var organizeQuestions: [[Question]] = [[],[],[],[],[],[],[],[]]
        // עוברים על כל שאלה ברשימת השאלות
        for question in questions {
            // מוסיפים את השאלה לקבוצה המתאימה לפי הספר שלה למערך שהגדרנו אורגנייזקוושן
            organizeQuestions[question.book].append(question)
        }
        //מחזיר את הסידור של השאלות לפי קבוצות לפי הספרים
        return organizeQuestions
    }
    
    //הפונקציה בונה רשימת ספרים מתוך קבוצת השאלות מסודרות לפי ספר
    private func populatedBooks(with questions: [[Question]]) {
        //הגדרנו את הספרים והמספר הסידורי שלהם שהשאלות יוכלו להתאים את עצמם
        //בנוסף לכך הגדרנו את הסטטוס שלהם מה יהיה נעול לשימוש ומה פתוח
        books.append(Book(id: 1, image: "hp1", questions: questions[1], status: .active))
        books.append(Book(id: 2, image: "hp2", questions: questions[2], status: .active))
        books.append(Book(id: 3, image: "hp3", questions: questions[3], status: .inactive))
        books.append(Book(id: 4, image: "hp4", questions: questions[4], status: .locked))
        books.append(Book(id: 5, image: "hp5", questions: questions[5], status: .locked))
        books.append(Book(id: 6, image: "hp6", questions: questions[6], status: .locked))
        books.append(Book(id: 7, image: "hp7", questions: questions[7], status: .locked))
    }
}
