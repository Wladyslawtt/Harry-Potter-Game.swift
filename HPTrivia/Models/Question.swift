//
//  Question.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 29/06/2025.
//
//יצרנו פיאנוח קובץ גייסון עם שאלות
struct Question: Decodable {
    let id: Int //כאן אנו מגדירים את הקרטריון כפי שרשום בגייסון ואיזה סוג הוא
    let question: String
    let answer: String
    let wrong: [String] //שמנו במרכאות בגלל שיש יותר מתשובה אחת
    let book: Int
    let hint: String
}
