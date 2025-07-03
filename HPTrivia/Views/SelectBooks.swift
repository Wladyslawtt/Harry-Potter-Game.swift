//
//  SelectBooks.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 03/07/2025.
//

import SwiftUI

struct SelectBooks: View {
    //השורה הזאת נותנת לנו שהחלון יהיה ניתן לסגירה
    @Environment(\.dismiss) private var dismiss
    //השורה הזו נותנת לנו גישה לאובייקט גיים שהוגדר בסביבת אב
    @Environment(Game.self) private var game
    
    var body: some View {
        ZStack{
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                    Text("Which books would you like to see questions from?")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                
                ScrollView{
                    //שמנו רשת של שני עמודות שוכבות
                    LazyVGrid(columns: [GridItem(),GridItem()]) {
                        //כאן הגדרנו שיתאים כל ספר עם השאלות שלו למשבצת משלו
                        ForEach(game.bookQuestions.books) { book in
                            //אם הסטטוס של כל ספר פעיל
                            if book.status == .active {
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
                              //אם הסטטוס של כל ספר לא פעיל
                            } else if book.status == .inactive {
                                ZStack {//מראה את כל הספרים הסגורים
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                }
                              //אחר
                            } else {
                                ZStack {//מראה את שאר הספרים
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                
                //יצרנו כפתור שיהיה אפשר לסגור את החלון
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {//פה הגרנו שיופיע כפי שמופיע בסביבת אב
    SelectBooks()
        .environment(Game())
}
