//
//  ActiveBook.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 03/07/2025.
//

import SwiftUI

struct ActiveBook: View {
    //יבאנו את המשתנה בוק
    //סטייט אומר לעקוב אחר השינויים במשתנה
    //הוא אם נקודותיים בגלל שבמשתנה יש כמה ערכים
    @State var book: Book
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {//מראה את כל הספרים הפתוחים
            Image(book.image)
                .resizable()
                .scaledToFit()
                .shadow(radius: 7)
            
            //הוספנו וי שיראה מה פתוח
            Image(systemName: "checkmark.circle.fill")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.green)
                .shadow(radius: 1)
                .padding(3)
        }
    }
}

#Preview {
    ActiveBook(book: BookQuestions().books[0])
}
