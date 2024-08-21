//: [Previous](@previous)

import UIKit

/*
 Hue 클래스는 BranFood에, BranFood는 Bran 클래스에 의존하는 코드
 Hue 클래스는 BranFood에 의존한다 -> BranFood에서 변화가 일어나면 Hue 클래스에 영향을 준다
 
 A가 B에 의존한다 -> B에서 변화가 발생했을 때, A에 영향을 미친다

 => Dependency가 발생!
 
 휴님 - 상위 모듈, BranFood - 하위 모듈
 
 >> 하위 모듈에서 변화가 상위 모듈에 영향을 미치지 않도록 코드를 구성해볼 수 없을까?
 >> 구현체가 아닌 인터페이스 추상화(Protocol, Interface)에 의존한다
 >> 식당이 바뀌거나 주인장이 바뀌더라도 코드에 휴님의 코드에 영향이 없으려면 어떻게 개선해야 할까?
 >> 인터페이스로 의존 관계를 추상화 해보자~
 
 */

class Hue {
    var food = BranFood()
    
    func 점심() -> String {
        food.점심특선()
    }
}

class BranFood {
    private let 주인장 = Bran()
    
    func 점심특선() -> String {
        주인장.국밥() + 주인장.꿔바로우() + 주인장.평양냉면()
    }
}

class Bran {
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
