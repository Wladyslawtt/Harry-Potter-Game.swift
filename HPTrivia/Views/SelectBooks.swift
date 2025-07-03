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
    
    //הוספנו משתנה כבוי להתרעה זמנית
    @State private var showTempAlert = false
    
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
                                .onTapGesture {//בזמן הלחיצה הספר משנה את הסטטוס ללא פעיל
                                    game.bookQuestions.changestatus(of: book.id, to: .inactive)
                                }
                                
                              //אם הסטטוס של כל ספר לא פעיל
                            } else if book.status == .inactive {
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
                                .onTapGesture {//בזמן הלחיצה הספר משנה את הסטטוס לפעיל
                                    game.bookQuestions.changestatus(of: book.id, to: .active)
                                }
                                
                              //אחר
                            } else {
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
                                .onTapGesture {
                                    showTempAlert.toggle()
                                    //בזמן הלחיצה הספר משנה את הסטטוס לפעיל
                                    game.bookQuestions.changestatus(of: book.id, to: .active)
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
        //הגדרנו התרעה בעת רכישה
        .alert("You purchased a new question pack", isPresented: $showTempAlert) {
        }
    }
}

#Preview {//פה הגרנו שיופיע כפי שמופיע בסביבת אב
    SelectBooks()
        .environment(Game())
}
