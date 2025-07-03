//
//  LockedBook.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 03/07/2025.
//

import SwiftUI

struct LockedBook: View {
    //יבאנו את המשתנה בוק
    //סטייט אומר לעקוב אחר השינויים במשתנה
    //הוא אם נקודותיים בגלל שבמשתנה יש כמה ערכים
    @State var book: Book
    
    var body: some View {
        ZStack {//מראה את שאר הספרים
            Image(book.image)
                .resizable()
                .scaledToFit()
                .shadow(radius: 7)
                .overlay {
                    Rectangle().opacity(0.75)
                }
            
            //הוספנו מנעול שיראה מה נעול
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .imageScale(.large)
                .shadow(color: .white,radius: 2)
                .padding(3)
        }
    }
}

#Preview {
    LockedBook(book: BookQuestions().books[0])
}
