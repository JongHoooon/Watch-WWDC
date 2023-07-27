# ARC in Swift- Basics and beyond


## Object lifetimes and ARC

![](https://velog.velcdn.com/images/qnm83/post/4b35f886-88ef-4a49-8140-14a2ce61d07b/image.png)

- 객체의 lifetime은 초기화를 통해 시작하고 마직막 사용 후 끝난다.
- ARC는 lifetime이 끝나면 객체의 할당을 해제한다.
- ARC는 객체의 lifetime을 reference count를 사용해 추적한다.
- Swift `컴파일러`는 retain / release 연산자를 삽입한다.
- Swift는 `runtime`에 reference count가 0 이면 할당을 해제한다.


<br>

- 참조가 시작될 때 retain 삽입
- 참조의 마지막 사용후 release 삽입

### Compiletime

![](https://velog.velcdn.com/images/qnm83/post/feb25d71-666c-4728-87ff-7c41517a7c65/image.png)

- traveler1은 Traveler 객체에 첫번째 참조이다.
- traveler1의 마지막 사용은 복사이다(traveler2에 복사)

![](https://velog.velcdn.com/images/qnm83/post/70216e60-5ee3-4a78-b788-615cb0076f10/image.png)

- traveler1의 마지막 사용 직후 Swift Compiler가 release를 삽입
- retain을 삽입하지 않았는데, initialization이 reference count를 1로 설정해준다. 

![](https://velog.velcdn.com/images/qnm83/post/31d4cde9-d971-4c3d-9cc5-d1ef44858127/image.png)

- traveler2는 Traveler 객체의 또 다른 참조이다.
- traveler2의 마지막 사용은 destination 업데이트 작업이다.

![](https://velog.velcdn.com/images/qnm83/post/84d11475-580c-460d-afb5-ebe84841e885/image.png)

- Swift Compiler는 참조가 시작될 때 retain 연산자를 삽입합니다.
- 참조의 마지막 사용 직후 release 연산자를 삽입합니다.


### Runtime



![](https://velog.velcdn.com/images/qnm83/post/87409ae9-51c2-41ec-ac2b-d93178852bec/image.png)

- Traveler 객체가 heap에 생성되고 reference count 1로 설정


![](https://velog.velcdn.com/images/qnm83/post/d579ba35-e8d0-411e-a454-bd09dc7f4d6d/image.png)

- Traveler 객체의 추가 참조로 reference count 2로 증가

![](https://velog.velcdn.com/images/qnm83/post/a46e4ba5-e6f5-4216-8bac-17f178fa529c/image.png)

- Traveler 1의 마지막 사용 후 reference count 1로 감소

![](https://velog.velcdn.com/images/qnm83/post/1c896b4c-70f5-488d-a1a2-deb0f97ca51c/image.png)

- traveler2의 destination 업데이트하는 마지막 사용 후 reference count 0으로 감소
- referece count가 0 이므로 할당 해제할 수 있다.

<br>
<br>

![](https://velog.velcdn.com/images/qnm83/post/24e86499-b39f-4ebf-a63f-a56d4895d1d4/image.png)

![](https://velog.velcdn.com/images/qnm83/post/709eff18-05ba-4809-9b99-69be6deaf32a/image.png)


- Swift에서 객체의 lifetime은 사용 기반이다(use-based)
- 객체의 초소 lifetime이 보장된다(초기화 후 시작 - 마지막 사용 후 끝)
  - C++이랑 다름
  - C++의 lifecycle은 '}' 에 도달했을 때 까지 보장됨
  
![](https://velog.velcdn.com/images/qnm83/post/c7f43bf9-7e89-41cb-b010-98c6f45a1a2c/image.png)

- 실제로는 최소 관찰되는 lifetime은 최소 보장과 다르게 마지막 사용 이후에 종료된다.(HERE에서 해제됨)
  - retain, release 연산자로 관리돼서 차이날 수 있음
  - ARC 최적화에 따라 달라짐
  - 대부분의 경우 에서는 문제 안됨
  
![](https://velog.velcdn.com/images/qnm83/post/5cbbe8da-a163-4a03-8ec6-5af61818be3c/image.png)


- Weak & unowned 참조, Deinitializer의 size-effects 를 활용하면 해결 가능 

![](https://velog.velcdn.com/images/qnm83/post/e57b5a93-cdfa-4351-a6ce-843035139eaa/image.png)


- guranteed object lifetime 대신에 observed object lifetime에 의존하면 나중에 버그 생김


<br><br>

## Observable object lifetimes

![](https://velog.velcdn.com/images/qnm83/post/727a73e1-a18f-4137-a6e7-9decda7c6f07/image.png)

- weak, unowned 참조를 사용하면 reference counting에 참여하지 않는다. 그래서 reference cycle을 해제하는데 많이 사용한다.

![](https://velog.velcdn.com/images/qnm83/post/3cd1b3fc-c801-4d76-a6ff-6f72b982255d/image.png)

- Account는 Traveler를 참조하고 Traveler는 Account를 참조한다.

![](https://velog.velcdn.com/images/qnm83/post/5ab804fe-b31c-43e4-af6f-886993385bc7/image.png)

- Traveler 객체 생성

- Traveler reference count: 1

![](https://velog.velcdn.com/images/qnm83/post/78163c57-c05e-4cde-a79a-fc0fc3ba6758/image.png)

- Account 객체 생성
- account가 traveler 참조


- Traveler reference count: 2
- Account reference count: 1

![](https://velog.velcdn.com/images/qnm83/post/b82fa56e-49ee-4524-8515-530838c1a295/image.png)

- traveler가 account 참조


- Traveler reference count: 2
- Account reference count: 2

![](https://velog.velcdn.com/images/qnm83/post/bbd02c0a-227d-4fdc-9ba5-f0abb443d7d4/image.png)

- account의 마지막 사용


- Traveler reference count: 2
- Account reference count: 1

![](https://velog.velcdn.com/images/qnm83/post/47912619-bbae-4d3b-82cf-f3496f07db6c/image.png)

- traveler의 마지막 사용


- Traveler reference count: 1
- Account reference count: 1


![](https://velog.velcdn.com/images/qnm83/post/481da5e2-7c2b-490b-8bc2-e72035473142/image.png)

- 순환 참조때문에 reference count 1씩 남음
- 메모리에서 해제 안됨
- 메모리 누수 발생

![](https://velog.velcdn.com/images/qnm83/post/d7b0eb0e-1374-4ea1-ada3-fcfd8f1e52da/image.png)

- weak or unowned를 사용하면 참조중인 객체가 사용중에 메모리에서 해제될 수도 있습니다.

![](https://velog.velcdn.com/images/qnm83/post/1fa41d1f-8fa7-40ac-be09-6ecbf6c86810/image.png)

![](https://velog.velcdn.com/images/qnm83/post/1e12c398-4ed0-49ad-9968-97206d54d07f/image.png)


- Account의 traveler를 weak로 선언해 순환 참조 방지

- guaranted object lifetime이후에 약한 참조에 접근하거나 observed object lifetime에 의존하면 나중에 버그 발생


![](https://velog.velcdn.com/images/qnm83/post/7c10d380-a101-4fb7-beb7-278fe55451e9/image.png)

- Account로 printSummary 메소드 이동
- traveler의 name 과 points의 print는 우연이다(실패할 수있다.)
- 메모리에서 해제된 traveler를 참조할 수 있다.

![](https://velog.velcdn.com/images/qnm83/post/b5878bda-5f5b-410a-b578-f3e7b63019eb/image.png)

- 강제 언랩핑대신 옵셔널 바인딩 사용
- 옵셔널 바인딩은 문제를 더 악화시킨다.
  - crash 대신 silent bug 생성


![](https://velog.velcdn.com/images/qnm83/post/8d9431ad-8865-41dc-9edf-bcaef363b074/image.png)


- weak, unowned reference를 안전하게 다루는 방법
- 각각은 초기 구축 비용과 지속적인 유지 비용의 정도가 다릅니다.

![](https://velog.velcdn.com/images/qnm83/post/1bbc2c9d-7b20-4b50-a6b1-ce5e99ddd82d/image.png)

- withExtendedLifetime()을 사용하면 안전하게 객체의 lifetime을 연장할 수 있습니다.

![](https://velog.velcdn.com/images/qnm83/post/b7b59bb0-f1e9-48a4-9a7d-9dfd6853f885/image.png)

- scope의 마지막에 빈 withExtendedLifetime()을 놓아도됨

![](https://velog.velcdn.com/images/qnm83/post/82a00a08-04b8-4728-b154-6ab45f29f4f8/image.png)

- defer을 사용해도 됨

- 쉽게 lifetime 버그 잡는거같지만 이 기술을 fragile 하고 정확성의 책임을 너에게 전달한다
- 이러한 저근방식으로는 약한 참조가 버그를 발생시킬 가능성이 있는데 마다 withExtendedLifetime()을 사용해야된다.
- withExtendedLifetime이 제어되지 않으면 유지 보수 비용을 증가시킬 수 있다.

![](https://velog.velcdn.com/images/qnm83/post/7239fb45-5b55-40ea-9937-76e01c8e679e/image.png)

- printSummary()를 Traveler로 올겼고 printSummary()는 이제 강한참조를 통해서만 호출됩니다.
- weak, unowned 참조는 성능 부담외에도 클래스 설계를 주의하지 않으면 문제를 일으킬 수 있다.

<br>

- weak, unowned는 순환 참조를 피할 때만 사용해야되나??
- 처음 부터 피하게 설계한다면??

![](https://velog.velcdn.com/images/qnm83/post/8807b47d-7833-43bf-b936-c8c0798f164d/image.png)

![](https://velog.velcdn.com/images/qnm83/post/75db8bd1-fc18-4b8a-a30e-bac1121ae3c9/image.png)

- Account class는 traveler의 personal information에만 접근하면됨.
- traveler의 개인정보를 PersonalInfo라는 새로운 class로 이동
- 추가 구현 비용이 들지만 잠재적인 객체 수명 버그를 제거하는 명확한 방법이다.

![](https://velog.velcdn.com/images/qnm83/post/456af277-c2c9-4558-9dd9-f6fe93205776/image.png)

- 객체의 수명을 관찰할 수 있는 다른 방법은 deinitializer의 side-effect이다.
- 할당이 해제되지 전에 실행되고 side effect로 외부 프로그램에 영향을 줄 수 있다.
- 외부 프로그램에 영향을 주는 연속 deinitializer를 작성한다면 버그로 이어질 수 있다.

![](https://velog.velcdn.com/images/qnm83/post/25bf4201-1cf5-44df-a15d-23a23cbe54f3/image.png)
![](https://velog.velcdn.com/images/qnm83/post/5ed8c12e-b81c-423a-8641-69d5d395482a/image.png)
 

- deinitializer는 print하는 글로벌 사이드 이펙트 있다.
- 오늘은 "Done traveling" 이후에 deinitializer 실행되지만 다음에는 전에 deinitializer가 실행될 수 있다.
- ARC의 최적화에 따라 달라짐


![](https://velog.velcdn.com/images/qnm83/post/2642221d-e8f6-4be0-b187-b6b7ccf9a48b/image.png)

- Traveler class에 TravelMetrics class를 도입함.
- Traveler 객체가 해제될 때, metric이 publish() 실행
 
![](https://velog.velcdn.com/images/qnm83/post/602b0622-aaa8-4371-a9f2-e2c295ec8ef1/image.png)

![](https://velog.velcdn.com/images/qnm83/post/b0d43791-7ee1-4b90-ad51-f9b655e0082f/image.png)

- computTravelInterest()와 verifyGlobalTravelMetric()의 순서가 상황에 따라 바뀐다.
- 할당 해제후 computTravelInterest() 실행되면 nil 값으로 버그 발생

![](https://velog.velcdn.com/images/qnm83/post/a6481bc5-fb8a-4461-a812-fdbfd0090d45/image.png)

- deinitializer의 사이드이펙트 안전하게 해결하는 방법

![](https://velog.velcdn.com/images/qnm83/post/f817a8fb-44fc-4cee-8c2f-c6da93f2af15/image.png)

- withExtendedLifetime() 사용

![](https://velog.velcdn.com/images/qnm83/post/e1502f63-91c3-4676-b28d-be0393212891/image.png)

- internal -> private로 변경

![](https://velog.velcdn.com/images/qnm83/post/abf6be36-ebbf-4d9e-bc95-e73a4f5242f0/image.png)

- deinitializer 대신 defer 사용해 publish함
- deinitializer는 검증만함
- deinitializer의 사이드 이펙트를 제거하면 모든 잠재적 객체 수명 버그를 제거할 수 있다.

![](https://velog.velcdn.com/images/qnm83/post/af61bc76-aa3d-444e-9faa-8f4706a6c360/image.png)

- Xcode13 에서 "Optimize Object Lifetimes"이용 가능하다
- ARC 최적화로 수명을 단축시킨다.


<br>

## 참고

- https://developer.apple.com/videos/play/wwdc2021/10216/?time=1147