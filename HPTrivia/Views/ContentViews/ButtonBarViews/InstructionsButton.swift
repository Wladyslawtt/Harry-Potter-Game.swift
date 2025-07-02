//
//  InstructionsButton.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import SwiftUI

struct InstructionsButton: View {
    //יצרנו משתנה כבוי לכפתור הוראות
    @State private var showInstructions = false
    //יבאנו משתנה אנימייט מהמסך הראשי הגדרנו אותו בול
    //בול אומר זה יהיה או טרו או פולס
    //ביינדינג לוקח משתנה מהמסך הראשי שניתן לשינוי ומשנה אותו כאן לפי הצורך
    @Binding var animateViewsIn: Bool
    //עשינו זאת כי במסך הראשי הוא נמצא בתוך גאו רידר
    let geo: GeometryProxy //יבאנו גאו פרוטוקול כדי שיתאים את הכפתור לגודל המסך
    
    var body: some View {
        VStack {//זה כדי שנוכל להוסיף תצוגה לכל מה שזה עוטף
            if animateViewsIn {//אם האנימייט טרו אז לבצע
                Button {//כפתור הוראות
                    showInstructions.toggle()
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                //כאן הגדרנו שהכפתור יגיע מהצד
                .transition(.offset(x: -geo.size.width/4))
            }
        }
        .animation(.easeInOut(duration: 0.7).delay(2), value: animateViewsIn)//זו האנימציה עצמה
        .sheet(isPresented: $showInstructions) { //כאן אנו מחברים את הכפתור שיציג את החלון של ההוראות
            Insructions()
        }
    }
}

#Preview {
    GeometryReader { geo in
        InstructionsButton(animateViewsIn: .constant(true), geo: geo)
    }
}
