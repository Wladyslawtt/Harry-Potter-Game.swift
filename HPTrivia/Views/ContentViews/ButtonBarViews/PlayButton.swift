//
//  PlayButton.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import SwiftUI

struct PlayButton: View {
    //יצרנו משתנה כבוי לאנימצית כפתור משחק
    @State private var scalePlayButton = false
    //יצרנו משתנה כבוי לכפתור משחק
    @State private var playGame = false
    //יבאנו משתנה אנימייט מהמסך הראשי הגדרנו אותו בול
    //בול אומר זה יהיה או טרו או פולס
    //ביינדינג לוקח משתנה מהמסך הראשי שניתן לשינוי ומשנה אותו כאן לפי הצורך
    @Binding var animateViewsIn: Bool
    //עשינו זאת כי במסך הראשי הוא נמצא בתוך גאו רידר
    let geo: GeometryProxy //יבאנו גאו פרוטוקול כדי שיתאים את הכפתור לגודל המסך
 
    
    var body: some View {
        VStack {//זה כדי שנוכל להוסיף תצוגה לכל מה שזה עוטף
            if animateViewsIn {//אם האנימייט טרו אז לבצע
                Button { //כפתור להתחלת משחק
                    playGame.toggle()
                } label: {
                    Text("Play")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 50)
                        .background(.brown)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(radius: 5)
                    //אם המשתנה דלוק האפקט יהיה אחד שתיים אם לא אז אחד
                        .scaleEffect(scalePlayButton ? 1.2 : 1)
                    //הפעלת האנימציה בעת פתיחת היישום
                        .onAppear {
                            //הגדרנו שהאנימציה תהיה גדילה והקטנה לאחד שלוש שניות לתמיד
                            withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                scalePlayButton.toggle()
                            }
                        }
                }
                //זו אנימציה כאילו הוא מעלה את הכפתור
                .transition(.offset(y: geo.size.height/3))
            }
        }
        .animation(.easeInOut(duration: 0.7).delay(2), value: animateViewsIn)//זו האנימציה עצמה
         
    }
}

#Preview {
    GeometryReader { geo in
        PlayButton(animateViewsIn: .constant(true), geo: geo)
    }
}
