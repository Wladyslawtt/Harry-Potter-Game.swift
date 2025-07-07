//
//  HPTriviaApp.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 29/06/2025.
//
//זו סביבת אב הסביבה הראשית
import SwiftUI

@main
struct HPTriviaApp: App {
    //הוספנו את התצוגה של המשחק עצמו
    private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game) //ופה הגדרנו שיהיה אפשר לגשת לתצוגה של המשחק מכל תצוגה ביישום
        }
    }
}


/**
 App Development Plan:
 ✅ Game inro screen
 ✅ GamePlay screen
 ✅ Game logic (questions, scores, etc)
 ✅Celebration
 ✅ Audio
 ✅ Animations
 - In-App purchases
 - Store
 ✅ Instructions screen 
 🟦 Books
 ✅ Persist scores
 
 ✅
 */
