//
//  SettingsButton.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import SwiftUI

struct SettingsButton: View {
    //יצרנו משתנה כבוי לכפתור הגדרות
    @State private var showSettings = false
    //יבאנו משתנה אנימייט מהמסך הראשי הגדרנו אותו בול
    //בול אומר זה יהיה או טרו או פולס
    //ביינדינג לוקח משתנה מהמסך הראשי שניתן לשינוי ומשנה אותו כאן לפי הצורך
    @Binding var animateViewsIn: Bool
    //עשינו זאת כי במסך הראשי הוא נמצא בתוך גאו רידר
    let geo: GeometryProxy //יבאנו גאו פרוטוקול כדי שיתאים את הכפתור לגודל המסך
 
    
    var body: some View {
        VStack {//זה כדי שנוכל להוסיף תצוגה לכל מה שזה עוטף
            if animateViewsIn {//אם האנימייט טרו אז לבצע
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                //כאן הגדרנו שהכפתור יגיע מהצד
                .transition(.offset(x: geo.size.width/4))
            }
        }
        .animation(.easeInOut(duration: 0.7).delay(2), value: animateViewsIn)//זו האנימציה עצמה
        //הגדרנו חלון קופץ לכפתור ההגדרות ואם הוא טרו
        .sheet(isPresented: $showSettings) {
            //הוא יקפיץ חלונית לבחירת ספר
            SelectBooks()
        }
    }
}

#Preview {
    GeometryReader { geo in
        SettingsButton(animateViewsIn: .constant(true), geo: geo)
            .environment(Game())
    }
}
