//: [Previous](@previous)

import Foundation

/*
 의존성 주입 (Dependency Injection)
 - 휴님 클래스는 잭반점 타입의 음식점을 이니셜라이저 시점에 주입을 받는다.
 - 휴님 클래스는 잭반점을 상속받는 어떤 인스턴스로도 생성이 가능하다.
 - 즉, 어떤 클래스가 들어올지는 모르지만 음식점 프로퍼티를 통해서 스페셜메뉴 메서드 사용 가능!
 
 >> 생성은 뭘로 될 지 모르지만 사용은 가능
 >> DI를 통해서 객체의 생성과 사용을 분리한다.
 
 DI vs DIP
 DI : 의존성 주입 (Dependency Injection)
 DIP: 의존관계 역전 원칙 (Dependency Inversion Principle) <프로토콜>
 
 휴님 > 잭반점 > 잭 으로 흘러가던 의존성 방향
 휴님 > 식당 < 잭반점
 잭반점 > 주방장요리 < 잭 으로 의존성 방향이 변경!
 
 DI를 적용했다고 해서, DIP를 준수하고 있는 것은 아니다. -> 스페셜메뉴() != 스페셜메()
 DIP를 구현하는 기법 중 하나로 DI를 사용할 수 있음.
 
 하위 모듈의 변화가 상위 모듈에 영향 미치지 않도록 하고
 구현체가 아닌 추상화에 의존하도록 한다
 
 */

protocol 음식점 {
    func 점심메뉴()
}

class 휴님 {
    var 음식점: 음식점
    
    init(음식점: 음식점) {
        self.음식점 = 음식점
    }
    
    func 점심() {
        음식점.점심메뉴() // 프로토콜에 있는 거. 음식점 따르는 모든 것
    }
}

// 하위에서 변해도 달라지는 거 없음
class 잭반점: 음식점 {
    private let 주인: 잭!
    
    init(주인: 잭) {
        self.주인 = 주인
    }
    
    func 점심메뉴() {
        print(주인.꿔바로우())
        print(주인.국밥())
        print(주인.평양냉면())
    }
}

class 잭 {
    let 이름: String
    let 나이: Int
    
    init(이름: String, 나이: Int) {
        self.이름 = 이름
        self.나이 = 나이
    }
    
    func 꿔바로우() { }
    func 국밥() { }
    func 평양냉면() { }
    
}

let man = 잭(이름: "asd", 나이: 123)
let food = 잭반점(주인: man)

//: [Next](@next)
