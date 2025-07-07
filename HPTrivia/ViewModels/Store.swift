//
//  Store.swift
//  HPTrivia
//
//  Created by Vladyslav Tarabunin on 07/07/2025.
//

import StoreKit

@MainActor
@Observable
class Store {
    //יצרנו מערך של מוצרים שיאחסן מוצרים בברירת מחדל הוא ריק
    var products : [Product] = []
    //יצרנו משתנה של קנויים שהוא קבוצה סט של מחרוזות ריקה בהתחלה
    //סט מאפשר לשמור פריט רק פעם אחת
    //זאת אומרת אחרי שקנית אותו אים אפשר לקנות אותו דבר שוב
    var purchased = Set<String>()
    //יצרנו משתנה בשם עדכונים
    //סוג המשתנה הוא טאסק משימה אסינכרוני. וויד לא מחזיר ערך. נבר לעולם לא נכשל. ניל זהו ערך התחלתי כלומר בהתחלה אין טאסק משימה
    //ככה מקשרים את אפליקציה לאפ סטור
    private var updates: Task<Void, Never>? = nil
    
    //Load available products
    func loadProducts() async {
        do {
            //מבקש מידע על מוצרים מהאפ סטור
            //את המוצרים הגדרנו בקונפיג אייצפי
            //זה מחזיר רשימה של מוצרים עם הפרטים שלהם
            //אויט טריי שמנו כי הפעיולה עלולה להיכשל
            products = try await Product.products(for: ["hp4","hp5","hp6","hp7"])
            //המוצרים שנקלטו יהיו ממוינים
            products.sort {
                //היא ממיינת לפי שם בסדר עולה של האלף בית
                $0.displayName < $1.displayName
            }
        } catch {
            print("Unable to load products: \(error)")
        }
    }
    //Purchase a product
    
    //Chack for purchased products
    
    //Connect with App Store to watch for purchase and transaction update
}
