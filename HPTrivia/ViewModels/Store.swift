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
    //זאת אומרת אחרי שקנית אותו אי אפשר לקנות אותו דבר שוב
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
    //הפונקצייה מקבלת פרמטר אחד מסוג פרודוקט ומנסה לבצע רכישה איתו ברקע עם אסינק
    func purchase(_ product: Product) async {
        do {
            //הגדרנו שינסה לקנות את המוצר
            let result = try await product.purchase()
            //אלו האפשרויות מה יקרה לאחר ניסיון קניה
            switch result {
            //הקניה הצליחה. וצריך לאשר את הקבלה והעברת הכסף
            case .success(let verificationResult):
                //הגדרנו סוגים של אישורים כדי שיבדוק אם האישור אמיתי או מזויף
                switch verificationResult {
                //אם האישור לא מאומת או מזויף
                case .unverified(let signedType, let verificationError):
                    //מדווחים על שגיאה  ועוצרים את הרכישה
                    print("Error on \(signedType): \(verificationError)")
                //אם האישור מאומת ואמיתי
                case .verified(let signedType):
                    //מעבירים אותה לאפל לסיום הרכישה
                    purchased.insert(signedType.productID)
                //מודיע לאפ סטור שסיימנו לבדוק את הרכישה כדי שלא תשאר תלויה
                    await signedType.finish()
                }
                
            //המשתמש ביטל את הקניה או ההורים לא אישרו לילד את הקניה
            case .userCancelled:
                break //הגדרנו שפשוט לא יעשה כלום
                
            //מחכה לאישור הקניה כמו ילד שמחכה לאישור מההורים
            case .pending:
                break //הגדרנו שפשוט לא יעשה כלום
                
            //זה ברירת מחדל לכל אופציה אחרת
            @unknown default: //כברירת מחדל הגדרנו לשבור את הסוויצ ולא לעשות כלום
                break
            }
        } catch {
            print("Unable to purchase product: \(error)")
        }
    }
    //Chack for purchased products
    
    //Connect with App Store to watch for purchase and transaction update
}
