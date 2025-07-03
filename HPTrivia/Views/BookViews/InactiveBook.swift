//
//  InactiveBook.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 03/07/2025.
//

import SwiftUI

struct InactiveBook: View {
    //יבאנו את המשתנה בוק
    //סטייט אומר לעקוב אחר השינויים במשתנה
    //הוא אם נקודותיים בגלל שבמשתנה יש כמה ערכים
    @State var book: Book
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {//מראה את כל הספרים הסגורים
            Image(book.image)
                .resizable()
                .scaledToFit()
                .shadow(radius: 7)
                .overlay {
                    Rectangle().opacity(0.33)
                }
            
            //הוספנו עיגול ריק שיראה מה סגור
            Image(systemName: "circle")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.green.opacity(0.5))
                .shadow(radius: 1)
                .padding(3)
        }
    }
}

#Preview {
    InactiveBook(book: BookQuestions().books[0])
}
