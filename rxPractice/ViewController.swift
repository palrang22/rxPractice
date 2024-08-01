//
//  ViewController.swift
//  rxPractice
//
//  Created by 김승희 on 8/1/24.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    // 구독 끝낸 뒤 구독 해제하기 위한 disposeBag
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // test()
        // test2()
        // test3()
        // test4()
        test5()
    }
    
    func test() {
        // String형 데이터를 방출
        let nameObservable: Observable<String> = Observable.create { observer in
            observer.onNext("SH")
            observer.onNext("Palrang")
            observer.onNext("Kim")
            
            return Disposables.create ()
        }
        // 위의 옵저버블을 구독해야 코드가 동작
        nameObservable.subscribe(onNext: { value in
            print("이름: \(value)")
        }, onCompleted: {
            print("끝")
        }).disposed(by: disposeBag)
        
        // 동기적으로 실행되므로 하이가 나중에 찍힘
        print("하이")
    }
    
    func test2() {
        // 1초마다 정수형 데이터를 방출
        // scheduler: 스레드와 같은 의미 (메인스레드에서 1초마다 방출하겠다)
        let someObservable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(5)
        
        someObservable.subscribe(onNext: { value in
            print("방출된 값: \(value)")
        }, onCompleted: {
            print("completed")
        }).disposed(by: disposeBag)
        
        // 비동기적 수행이기 때문에 헬로가 먼저 찍힘
        print("헬로")
    }
    
    // Single
    func test3() {
        let single = Single.create { observer in
            observer(.success("Palrang"))
            return Disposables.create()
        }
        
        single.subscribe(onSuccess: { value in
            print(value)
        }).disposed(by: disposeBag)
    }
    
    // BehaviorSubject
    func test4() {
        // 초기값을 넣어줘서 타입을 알 수 있기 때문에 제네릭을 선언하지 않음
        let subject = BehaviorSubject(value: 10)
        
        subject.subscribe(onNext: { value in
            print("값 방출: \(value)")
        }).disposed(by: disposeBag)
        
        // Subject는 외부에서도 값을 넣어줄 수 있음
        subject.onNext(20)
        subject.onNext(30)
    }
    
    // PublishSubject
    func test5() {
        let subject = PublishSubject<Int>()
        
        subject.subscribe(onNext: { value in
            print("값 방출: \(value)")
        }).disposed(by: disposeBag)
        
        subject.onNext(20)
        subject.onNext(30)
    }
}

