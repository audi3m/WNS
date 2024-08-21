//: [Previous](@previous)

/*
 <식당>, <주방장>
 
 Hue 클래스는 BranFood나 DenFood 같은 구현체에 의존하고 있지 않고,,,
 대신, 식당이라는 프로토콜에 의존하고 있다.
 식당이라는 프로토콜을 채택하고 있는 어떤 구체 타입(Concrete Type)들을 모두 적용할 수 있다. -> Solid
 
 휴님 > 잭반점 > 잭 으로 흘러가던 의존성 방향
 휴님 > 식당 < 잭반점
 잭반점 > 주방장요리 < 잭 으로 의존성 방향이 변경!
 
 */

import Foundation

protocol Mentor { }

class Jack: Mentor { }
class Test: Mentor { }

var a: Mentor = Jack()
a = Test()

protocol 식당 {
    func 점심메뉴() -> String
}

protocol 주방장요리 {
    func 평양냉면() -> String
    func 국밥() -> String
    func 꿔바로우() -> String
}

class Hue: 식당 {
    var food: 식당!
    
    func 점심메뉴() -> String {
        food.점심메뉴()
    }
}

let hue = Hue()
hue.food

class BranFood: 식당 {
//    private var 주인장: 주방장요리 = Bran()
    private var 주인장: 주방장요리!
    
    
    func 점심메뉴() -> String {
        주인장.국밥() + 주인장.꿔바로우() + 주인장.평양냉면()
    }
}

class Bran: 주방장요리 {
    func 평양냉면() -> String {
        "맛있는 냉면"
    }
    
    func 국밥() -> String {
        "맛있는 국밥"
    }
    
    func 꿔바로우() -> String {
        "맛있는 꿔바로우"
    }
}

class DenFood: 식당 {
    private let 주인장 = Den()
    
    func 점심메뉴() -> String {
        주인장.국밥() + 주인장.꿔바로우() + 주인장.평양냉면()
    }
}

class Den: 주방장요리 {
    func 평양냉면() -> String {
        "맛있는 냉면"
    }
    
    func 국밥() -> String {
        "맛있는 국밥"
    }
    
    func 꿔바로우() -> String {
        "맛있는 꿔바로우"
    }
}









//: [Next](@next)
