//
//  GameTitle.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import SwiftUI

struct GameTitle: View {
    //יבאנו משתנה אנימייט מהמסך הראשי הגדרנו אותו בול
    //בול אומר זה יהיה או טרו או פולס
    //ביינדינג לוקח משתנה מהמסך הראשי שניתן לשינוי ומשנה אותו כאן לפי הצורך
    @Binding var animateViewsIn: Bool
    
    var body: some View {
        VStack {//זה כדי שנוכל להוסיף תצוגה לכל מה שזה עוטף
            if animateViewsIn { //אם האנימייט טרו אז לבצע
                VStack {
                    Image(systemName: "bolt.fill")
                        .imageScale(.large)
                        .font(.largeTitle)
                    
                    Text("HP")
                        .font(.custom("PartyLetPlain", size: 70))
                        .padding(.bottom, -50)
                    
                    Text("Trivia")
                        .font(.custom("PartyLetPlain", size: 60))
                }
                .padding(.top, 70)
                .transition(.move(edge: .top))
                //זו אנימציה שכאילו הוא מוריד את הלוגו
            }//זה הסוג של האנימציה שאנו רוצים
        }
        .animation(.easeInOut(duration: 0.7).delay(2), value: animateViewsIn)//זו האנימציה עצמה
        
    }
}

#Preview {
    //כאן הגדרנו שהביינדינג ישנה לטרו את המשתנה
    GameTitle(animateViewsIn: .constant(true))
}
