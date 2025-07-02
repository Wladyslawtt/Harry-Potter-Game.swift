//
//  RecentScores.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import SwiftUI

struct RecentScores: View {
    //יבאנו משתנה אנימייט מהמסך הראשי הגדרנו אותו בול
    //בול אומר זה יהיה או טרו או פולס
    //ביינדינג לוקח משתנה מהמסך הראשי שניתן לשינוי ומשנה אותו כאן לפי הצורך
    @Binding var animateViewsIn: Bool
    
    var body: some View {
        VStack { //תצוגת לוח התוצאות שלנו
            if animateViewsIn {
                VStack {//לוח תוצאות
                    Text("Recent Scores")
                        .font(.title2)
                    
                    Text("33")
                    Text("27")
                    Text("15")
                }
                .font(.title3)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .background(.black.opacity(0.7))
                .clipShape(.rect(cornerRadius: 20))
                //זה אפקט שמעלים ומראה לנו אותו
                .transition(.opacity)
            }
        }
    .animation(.linear(duration: 1).delay(4), value: animateViewsIn)//זו האנימציה עצמה
     
    }
}

#Preview {
    //כאן הגדרנו שהביינדינג ישנה לטרו את המשתנה
    RecentScores(animateViewsIn: .constant(true))
}
