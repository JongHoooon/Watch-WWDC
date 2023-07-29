# Understanding Swift Performance
> Choosing the Right Abstarction Mechanism

<br> 

![](https://velog.velcdn.com/images/qnm83/post/ce4e413a-8b7b-451f-81c4-44e4cc4a9d7b/image.png)

- 추상화시 stack, heap 어디에 할당할지 생각해라
- 추상화시 이 인스턴스가 얼마나 많은 reference counting overhead를 발생시킬지 생객해라
- 인스턴스에서 method를 호출할때 정적으로 불릴지 동적으로 불릴지 생각해라
- 성능 개선하려면 dynamism, runtime을 피해라

## Allocation


![](https://velog.velcdn.com/images/qnm83/post/122f88f6-85c2-4473-b61a-63510e3295f0/image.png)

- stack의 끝에서만 push, pop이 발생한다.
- stack은 빠르게 할당하고 해제한다.


![](https://velog.velcdn.com/images/qnm83/post/61cc204e-0fea-4aaa-8657-714f38e74f4c/image.png)

- 동적이고 stack보다 비효율 적이다.
- 빈공간을 찾고 할당
- 동기화 작업 비용이 매우 크다 


![](https://velog.velcdn.com/images/qnm83/post/6a44dfc4-9cf2-4616-83ba-84988402df31/image.png)

- stack에 나란히 저장
- 두개는 독립적인 인스턴스이다
- 사용이 끝나면 메로리에서 해제되고 stack포인터가 올라간다.

![](https://velog.velcdn.com/images/qnm83/post/b3e3a01a-55c7-44bb-8b38-4886d399a929/image.png)

- heap에 참조를 위한 메모리할당하려고 한다.
- Swift는 heap을 lock하고 적당한 사이즈의 메모리 블록을 찾습니다.
- 찾으면 메모리에 point1 초기화 
- struct와 다르게 2 word 더 할당해 4 word(4 칸)을 사용합니다(파란색 칸)
- 참조를 공유해 의도하지 않은 상태변화가 발생할 수 있습니다.
- point1,2 사용이 끝나면 Swift는 lock하는 대신 메모리에서 해제합니다.
- 사용하지 않는 블락을 재배치하고 스택에서 pop합니다.


### 성능 개선

![](https://velog.velcdn.com/images/qnm83/post/636f76a5-7452-4809-81b5-db672b3fd25e/image.png)


- cache의 String은 아무값이나 들어갈 수 있어 불안정
- String을 구성하는 Character들이 간접적으로 힙영역에 저장돼 캐쉬 히트를 하더라도 힙 할당이 발생합니다.

![](https://velog.velcdn.com/images/qnm83/post/b18f52c0-ab8c-43b0-9ed9-5c1926495f1b/image.png)

- struct를 사용하면 더 안전하다
- 일급 객체여서 dictionary의 키값으로 사용가능하다.
- 이제는 캐쉬히트해도 힙할당을 하지않습니다.(stack에 할당된다.)

![](https://velog.velcdn.com/images/qnm83/post/1e7f795e-0eca-46af-bc36-0b68f7b8b464/image.png)

- Swift는 reference count를 사용해서 힙 영역을 관리합니다.
- 참조가 추가되면 count가 증가하고 참조가 제거되면 count가 감소합니다.
- count가 0이 되면 메모리에서 해제됩니다.
- reference count관려해 count를 올리고 내리는것은 빈번하고 말고도 더 많은 것들이 있습니다. 
  - count를 올리고 내리는것을 몇가지 수준의 indirection과 관련있습니다,.
  - thread safe 상태를 유지하기 위해 많은 비용이 듭니다.
  
  
![](https://velog.velcdn.com/images/qnm83/post/cfe7b35e-8cd2-42ab-a14b-f382b331f78c/image.png)

- 초기화시 ref count 1
- retain: ref count 증가
- release: ref count 감소

![](https://velog.velcdn.com/images/qnm83/post/34761a52-7efe-412e-8e0b-a356eef51de5/image.png)

- Label은 struct이지만 String과 UIFont 타입 때문에 ref count가 필요합니다.
- struct도 reference를 포함하면 reference counting이 필요합니다. 

![](https://velog.velcdn.com/images/qnm83/post/77effbad-82a2-4401-bf42-ce89af541a82/image.png)

![](https://velog.velcdn.com/images/qnm83/post/fed1260e-5761-4bce-ba15-2533e53ce62f/image.png)

- 참조 타입들을 값타입으로 변경해 referenc counting, heap allocation 발생을 줄임

<br>

## Method dispatch

![](https://velog.velcdn.com/images/qnm83/post/8aea7545-dd68-4253-aebe-52afc78e3a31/image.png)

- compile time에 어떤 함수가 실행될지 결정
- inline을 포함해 적극적인 최적화 가능

![](https://velog.velcdn.com/images/qnm83/post/feea1c6d-7607-4530-91d4-88bc1913d0c4/image.png)

- run time에 어떤 함수가 실행될지 결정
- 결정 후 구현부로 점프(오버 헤드)
- inline, 다른최적화 안됨

![](https://velog.velcdn.com/images/qnm83/post/c241d71e-2a83-4a75-a2e2-287138de32f6/image.png)

![](https://velog.velcdn.com/images/qnm83/post/cd7af33a-d509-47ac-8e0c-27e142bfae04/image.png)

- Static Dispatch는 Call Stack을 만들고 분해하지 않고
- Static Dispatch는 inline으로 Call Stack 오버헤드도 발생하지 않는다.

![](https://velog.velcdn.com/images/qnm83/post/ac27deeb-3be2-4947-a10d-e8385aac1a13/image.png)

- polymorphism 때문에 dynamic dispatch 사용한다.

![](https://velog.velcdn.com/images/qnm83/post/35d613c2-b9df-4379-a419-3653009b9d40/image.png)

- [Drawable] 배열은 참조로 구성돼 크기는 동일하다  
- d.draw는 컴파일 타임에 어떤 함수를 실행할지 결정할 수 없다(Point, Line 어떤게 될지 모름)

![](https://velog.velcdn.com/images/qnm83/post/63bbce61-b708-4ff0-b12c-02f1a2ab296a/image.png)

- 컴파일러는 클래스에 해당 클래스의 type 정보에 대한 포인터 field를 추가하고 static memory에 저장합니다.
- draw를 호출하면 컴파일러는 실행할 구현의 포인터를 포함하는 type 및 static memory의 가상 메소드 테이블을 조회합니다.
- 이후 실제 인스턴스를 implict self-parameter로 전달합니다.


- final 키워드를 사용하면 class도 static dispatch 할수있다.

<br>

## 참고

- https://developer.apple.com/videos/play/wwdc2016/416/?time=1327