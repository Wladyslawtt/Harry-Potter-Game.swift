//
//  ButtonBar.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import SwiftUI

struct ButtonBar: View {
    //יבאנו משתנה אנימייט מהמסך הראשי הגדרנו אותו בול
    //בול אומר זה יהיה או טרו או פולס
    //ביינדינג לוקח משתנה מהמסך הראשי שניתן לשינוי ומשנה אותו כאן לפי הצורך
    @Binding var animateViewsIn: Bool
    //עשינו זאת כי במסך הראשי הוא נמצא בתוך גאו רידר
    let geo: GeometryProxy //יבאנו גאו פרוטוקול כדי שיתאים את הכפתור לגודל המסך
 
    var body: some View {
        HStack { //תצוגת כל הכפתורים שלנו
            
            Spacer()
            //הדולר משתמש במשתנה המקור וגאו משתמש בגאו רידר
            InstructionsButton(animateViewsIn: $animateViewsIn, geo: geo)
            
            Spacer()
            //הדולר משתמש במשתנה המקור וגאו משתמש בגאו רידר
            PlayButton(animateViewsIn: $animateViewsIn, geo: geo)
            
            Spacer()
            //הדולר משתמש במשתנה המקור וגאו משתמש בגאו רידר
            SettingsButton(animateViewsIn: $animateViewsIn, geo: geo)
            
            Spacer()
        }
        //השורה הזו מתאימה את התצוגה לגודל המסך
        .frame(width: geo.size.width)
     
    }
}

#Preview {
    GeometryReader { geo in
        ButtonBar(animateViewsIn: .constant(true), geo: geo)
    }
}
