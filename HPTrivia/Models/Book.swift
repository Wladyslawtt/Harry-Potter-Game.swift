//
//  Book.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//
//יצרנו טיפוס בשם בוק שיוכל לזהות כל אובייקט לפי המספר או הנתון היחודי שלו
//שמנו אידנטיטי כדי שיהיה נתן להריץ בתוך לולאה
struct Book: Identifiable{
    let id: Int //כאן אנו מגדירים לפי מה הוא הולך לזהות את הספרים
    let image: String
    let questions: [Question]
    var status: BookStatus //יצרנו משתנה שיכול לשנות את המצב שלו עם הטיפוס בוקסטטוס
    
}
//בעיקרון הגדרנו אפשרויות איך הספרים יהיו למשתמש נעולים פתוחים או לא מושלמים
enum BookStatus {//כאן הגדרנו איזה מצבים יכולים להיות בטיפוס הזה
    case active, inactive, locked
}
