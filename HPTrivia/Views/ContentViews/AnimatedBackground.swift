//
//  AnimatedBackground.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 02/07/2025.
//

import SwiftUI

struct AnimatedBackground: View {
    //עשינו זאת כי במסך הראשי הוא נמצא בתוך גאו רידר
    let geo: GeometryProxy //יבאנו גאו פרוטוקול כדי שיתאים את הרקע לגודל המסך
    
    var body: some View {
        //תצוגת הרקע שלנו
            Image(.hogwarts)
                .resizable()
                .frame(width: geo.size.width * 3, height: geo.size.height)
                .padding(.top, 3)
                .phaseAnimator([false, true]) { content, phase in
                    content
                        .offset(x: phase ? geo.size.width/1.1 : -geo.size.width/1.1)
                } animation: { _ in
                        .linear(duration: 60)
                }//פייס זו האניצמייית תזוזה של הרקע

    }
}

#Preview {//הוספנו בפרוויו גרו רידר כי כך הוא מדמה לנו איך הוא נראה במסך הראשי ששם הוא גם עטוף בגאו רידר
    GeometryReader { geo in
        AnimatedBackground(geo: geo)
        //השורה הזו ממקמת את הרקע לאמצע המסך לפי הגודל שלו כדי שלא יזלוג לקצוות
            .frame(width: geo.size.width, height: geo.size.height)
    }
    .ignoresSafeArea()
}
