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
    //הבאנו את קובץ החנות
    private var store = Store()
    
    //הוספנו משתנה כבוי להתרעה זמנית
    @State private var showTempAlert = false
    
    //המטרה היא שיהיה לפחות ספר אחד פתוח לשחק בו
    //זו פונקציה שבודקת אם יש לפחות ספר אחד פעיל
    var activeBooks: Bool {
        //זו לולאה שרצה על כל ספר שנמצא במשחק שאלות הספרים
        for book in game.bookQuestions.books {
            if book.status == .active {
                //אם נמצא לפחות אחד פעיל הוא יחזיר טרו
                return true
            }
        }
        //אם לא נמצא שום ספר הוא יחזיר פולס
        return false
    }
    
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
                                ActiveBook(book: book)
                                
                                    .onTapGesture {//בזמן הלחיצה הספר משנה את הסטטוס ללא פעיל
                                        game.bookQuestions.changestatus(of: book.id, to: .inactive)
                                    }
                                
                              //אם הסטטוס של כל ספר לא פעיל
                            } else if book.status == .inactive {
                                InactiveBook(book: book)
                                
                                    .onTapGesture {//בזמן הלחיצה הספר משנה את הסטטוס לפעיל
                                        game.bookQuestions.changestatus(of: book.id, to: .active)
                                }
                                
                              //אחר
                            } else {
                                LockedBook(book: book)
                                
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
                //אם לא נמצא ספר פעיל אז תציג הודעת טקסט
                //הסימן קריאה לפני מילה מסמל שלילה פולס
                //בלי סימן קריאה זה מסמל טרו זאת אומרת אם כן
                if !activeBooks {
                    Text("You must select at least one book")
                        .multilineTextAlignment(.center)
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
                .disabled(!activeBooks)//אם אין ספרים פעילים אז הוא משבית את הכפתור
            }
            .foregroundStyle(.black)
        }
        //אם אין ספרים פעילים אז התצוגה לא תיסגר
        .interactiveDismissDisabled(!activeBooks)
        //הגדרנו התרעה בעת רכישה
        .alert("You purchased a new question pack", isPresented: $showTempAlert) {
        }
        //טאסק זו פעולה אוטומטית שרצה כשמופיע המסך
        .task {
            //פעולה איסנכרונית שטוענת מוצרים שהוגדרו בקובץ סטור
            await store.loadProducts()
        }
    }
}

#Preview {//פה הגרנו שיופיע כפי שמופיע בסביבת אב
    SelectBooks()
        .environment(Game())
}
