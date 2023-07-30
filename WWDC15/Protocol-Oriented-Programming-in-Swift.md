# Protocol Oriented Programming in Swift

## Table of contents

1. [Class(OOP) VS Struct, Enum(POP)](#classoop-vs-struct-enumpop)
2. [The Three Beefs](#the-three-beefs)
3. [Swift is a POP Language](#swift-is-a-protocol-oriented-programming-language)
4. [More Protocol Extension Tricks](#more-protocol-extension-tricks)
5. [They do have their place...](#theyclasses-do-have-their-place)

<br>

## Class(OOP) VS Struct, Enum(POP)

![](https://velog.velcdn.com/images/qnm83/post/45587666-e574-4a6b-a777-1a370113201f/image.png)


- Encapsulation: 그룹화
- Access Control: 접근 제어자
- Abstraction: 추상화
- Namespace: sofrware가 커지면서 발생하는 충돌을 막아준다
- Expressive Syntax: 저장/연산 프로퍼티, 메소드, 서브스크립션..
- Extensibility: 나중에 필요한거 추가 가능

Access Control, Abstraction, Namespace는 특히 복잡성(Complexity)을 관리하게 해줍니다.

![](https://velog.velcdn.com/images/qnm83/post/1b0a0c38-9b1a-4fbe-957a-05ca62909c19/image.png)

- struct, enum도 할 수 있음.
- Swift에서 이름 지을 수 있는 모든 type은 일급객체이고 위에 모든 특징을 갖을 수 있다.


![](https://velog.velcdn.com/images/qnm83/post/bf5202c0-72a4-4d97-a0df-6a1e89efc46d/image.png)

- 상속은 class만 가능

![](https://velog.velcdn.com/images/qnm83/post/ac50130a-5dff-4bb4-88fa-58d22a5b65c6/image.png)

- 상속을 통해 코드공유, 커스텀 가능(override)

- struct도 커스텀 가능
- class는 강력하지만 cost가 크다

<br>

## The Three Beefs

### 1. Implicit Sharing

![](https://velog.velcdn.com/images/qnm83/post/896cc63c-f1b1-4da8-91ea-4cdac38a99bd/image.png)

- 값 타입은 참조를 공유해 의도하지 않은 변화가 발생해 문제될 수 있다.

![](https://velog.velcdn.com/images/qnm83/post/d0e8ef68-a7e3-4d4b-ba9c-32398155d0d7/image.png)

- 값 타입은 cost가 크다


 ### 2. Inheritance All Up In Your Business
  
![](https://velog.velcdn.com/images/qnm83/post/cb5e150f-57b5-4f7e-97b3-f1fbec4a8227/image.png)

- Superclass 1개만 갖을 수 있다.
- 필요 없는것도 다 상속 받음
- class를 정의하는 순간 super class를 정해야한다.(extension으로 상속 불가능)
- Superclass에 저장 프로퍼티가 있다면
  - 상속 받아야만 한다.
  - 저장프로퍼티들을 초기화 해줘야한다.
  - superclass의 invariant를 깨면안된다.
- method들이 override될 건가 알아야한다.(final 키워드 명시)
- cocoa에서 delegate 패턴을 사용하는 이유입니다.

### 3. Lost Type Relationships

![](https://velog.velcdn.com/images/qnm83/post/970fe882-3002-499d-bb3a-44ad9caada94/image.png)

![](https://velog.velcdn.com/images/qnm83/post/002a8051-3fd1-43d8-ad69-1afc4677732d/image.png)

- Ordered의 precedes의 구현부에 어쩔수 없이 불안한 구현
- Number의 precede의 other은 Label이 될 수 도 있다.(static type safety hole)

![](https://velog.velcdn.com/images/qnm83/post/080dc4d2-f953-4754-a3c2-5d31b57b3ca0/image.png)

- as! ASubclass은 code smell 이다.
- as! ASubclass은 type relationship이 손상됐음을 의미한다.

![](https://velog.velcdn.com/images/qnm83/post/3c27b3a8-0bee-4311-81a8-f42aff948220/image.png)

- protocol로 하면됨

<br>

## Swift Is a Protocol-Oriented Programming Language

<br>

### Start with a Protocol
> Your first stop for new abstractions

![](https://velog.velcdn.com/images/qnm83/post/be83f05d-161b-43c4-8eac-db3946b6b20d/image.png)

- Ordered의 불필요한 구현부 삭제(fatal error 신경쓰지 않아도 됨)

![](https://velog.velcdn.com/images/qnm83/post/b20e2e08-bd8c-4caa-a2fc-41869c51b5ae/image.png)
![](https://velog.velcdn.com/images/qnm83/post/98c6ed9d-1257-44ac-a687-6d819b2e8f60/image.png)


- override 여부를 신경쓰지 않아도 됨
- 상속을 사용하지 않음으로 class -> struct로 변경

![](https://velog.velcdn.com/images/qnm83/post/6a282b38-96fc-4bcf-a8bf-47a46dd4f496/image.png)

![](https://velog.velcdn.com/images/qnm83/post/43b334b4-360f-4f82-ae1f-f2702b489ba1/image.png)

- 강제 타입캐스팅(static type safety hole) 제거
- Self는 자기 자신의 타입을 나타낸다.

### Using Our Protocol

![](https://velog.velcdn.com/images/qnm83/post/3096902d-190b-4f1c-b285-1d5ce4e3b10d/image.png)

- Ordered는 Label이 될 수 도있고 Number가 될수도있는 heterogeneous인 array라 컴파일러가 Homogeneous인 array로 바꾸라고한다.


![](https://velog.velcdn.com/images/qnm83/post/2f727f5a-4cf0-49e1-9622-01431069b2d7/image.png)

- generic을 사용하면 Homogeneous인 array로 인식시킬 수 있다.

![](https://velog.velcdn.com/images/qnm83/post/4edffd11-11f8-4f2e-8331-33c4b165d943/image.png)

<br>

### Protocols and Generics for Testability
 
- mocks은 테스팅 코드를 세부 구현과 연결해야 하지만 프로토콜은 연결을 끊을 수 있어 테스트하기 용이합니다.

- protocol은 우리에게 언어에 의해 강요되는 원칙적인 interface를 제공하기도 하고 우리가 필요한 도구들을 연결할 수 있는 hook을 제공하기도 합니다.


![](https://velog.velcdn.com/images/qnm83/post/a35bed1a-e958-4d64-a2c8-64c59a665054/image.png)

- extension을 사용해 반복되는 구현을 한번만 구현해 사용한다.


![](https://velog.velcdn.com/images/qnm83/post/c3c1b4be-9d8c-4931-9fcf-45d52fe2bc60/image.png)

- circleAt은 요구사항에 있고, extension에 구현
- rectangleAt은 요구사항에 없고, extension에 없음

![](https://velog.velcdn.com/images/qnm83/post/44faf538-1498-4afd-ba05-0d8b399c56e2/image.png)

- type inference을 시킬 경우에는 둘다 새로 커스텀한게 실행된다.

![](https://velog.velcdn.com/images/qnm83/post/70cc2d4d-3ca7-4fb4-a575-b7bc4d120e6a/image.png)

- type annotation 하면 요구상항에 없는 retangleAt은 커스텀한 부분이 아니라 protol의 extension에 구현한 부분이 실행된다.

<br>

## More Protocol Extension Tricks
> Scenes from the standard library and beyond

### Constrained extensions

![](https://velog.velcdn.com/images/qnm83/post/ff6a2439-756e-45ea-8485-e286e7000c1e/image.png)

- 어떤 collection의 요소들은 == 로 비교할 수 없다.

![](https://velog.velcdn.com/images/qnm83/post/e529eb2d-4452-4b09-873e-a084b04b04e9/image.png)

- where을 사용해 Equatable Protocol을 따르는 element들만 연산할 수 있게 수정


### Retroactive adaption

![](https://velog.velcdn.com/images/qnm83/post/d30965b2-b9a1-418a-ac49-0f9415fa0fab/image.png)

- Int는 Ordered 프로토콜을 채택하지 않아 사용이 불가능함

![](https://velog.velcdn.com/images/qnm83/post/5f384dbd-e52e-4512-a125-fbae135c1a1b/image.png)

- Int, String 이 Ordered 프로토콜을 채택하게해 사용가능하게 함 

![](https://velog.velcdn.com/images/qnm83/post/349aef5c-0b2d-4048-83c2-aff9dd40e2c8/image.png)

- Comparable 프로토콜에는 '<' 연산자가 이미 존해한다.
- Comparable에서 extension을 통해 precedes를 구현해 개선

![](https://velog.velcdn.com/images/qnm83/post/9ba9fec9-6eb4-441b-adab-e490b37c7eb7/image.png)

- Comparable을 확장해 Double 타입이 precedes 메소드를 사용할 수 있지만 Ordered 프로토콜을 채택하지 않아 Double 타입에서 binarySearch 메소드는 사용 불가능하다

![](https://velog.velcdn.com/images/qnm83/post/28aee2ac-884d-4b99-a19d-852285bf762d/image.png)

- constrained extension 사용해 Ordered 확장해 Ordered를 채택한 타입만 precedes 메소드와 binarySearch 메소드를 사용할 수 있게 함


### Generic beautification

![](https://velog.velcdn.com/images/qnm83/post/52c6ec03-01dd-463d-81b9-ecab5d1021cc/image.png)

- Swift1 의 fully generallized binary search

![](https://velog.velcdn.com/images/qnm83/post/64a80bcd-d7a4-4556-9214-8834b17a4e4e/image.png)

- Swift2 에서 Protocol을 사용해 개선

### Interface generation

![](https://velog.velcdn.com/images/qnm83/post/0dc47e24-bbae-46fa-9546-7ab0c68bc460/image.png)

- Protocol을 채택하면 extension에 구현된 인터페이스들 사용가능

### Building bridges between the static and dynamic worlds

![](https://velog.velcdn.com/images/qnm83/post/22f9bfb9-a1d8-48e6-bd73-5c2f3f195a3c/image.png)

- drawable 배열을 비교할 수 없다.

![](https://velog.velcdn.com/images/qnm83/post/fe9a3aa8-38c4-4165-b9b1-fcbadec93497/image.png)

- 배열의 count 가 같고 하나씩 비교해 같은지 확인
- Drawable은 Equatable 프로토콜을 채택하지 않아서 == 연산자로 비교할 수 없다.


![](https://velog.velcdn.com/images/qnm83/post/07463ca7-e79d-4313-9220-5d115fef968b/image.png)

- Equatable 프로토콜을 Self를 사용해 비교(Static Dispatch, Homogeneous)하는데 Drawable은 Circle이 될수도 Polygon이 될수도 있어(Dynamic Dispatch, Heterogeneous)서 충돌한다.

![](https://velog.velcdn.com/images/qnm83/post/83db6d55-7b82-4ad2-9ec9-07eed24e421d/image.png)

- isEqualTo 메소드를 사용해 비교한다.

![](https://velog.velcdn.com/images/qnm83/post/80fc21d4-d8d2-4f4d-baf3-5f694c2aced3/image.png)

- extension을 통해 다운 캐스팅을 통해서 type을 변형하면 Equatable을 채택하고 Self를 사용해 비교할 수 있다.
- Static Dispatch -> Dynamic Dispatch로 변경
- Heterogeneous -> Homogeneous로 변경

<br>

## They(Classes) do have their place...


### implicit한 공유가 필요할 때

![](https://velog.velcdn.com/images/qnm83/post/3b2fb613-350f-4155-874b-cf265ae1795d/image.png)

- 복사나 비교가 의미없는상태(Singleton 처럼 한번 만들어 놓고 쓰는거 말하는거 같음)(e.g., Window)
- 인스턴스의 생명주기가 외부요인과 관련있을때(e.g., TemporaryFile)
  - reference type은 안전한 identity가 있어 외부의 entity와 correspond하는 먼가를 만든다면 참조 타입을 사용해야 한다.
- 인스턴스는 데이터의 구조를 정의하고 상태를 저장하는데 사용되고 메서드는 해당 객체가 아닌 외부에서 수행한다.(e.g., CGCContext)

<br>

- 주의 사항
  - final로 선언
  - base class 없이 Protocol 사용



### Don't fight the system

![](https://velog.velcdn.com/images/qnm83/post/76a84dd0-7ef5-4fcb-a696-6e0fa4001986/image.png)


- 프레임워크를 바꾸려고 하지마라

### On the other hand, be circumspect

![](https://velog.velcdn.com/images/qnm83/post/617f5c88-04f0-4c73-b5b5-3f9b34a1d05d/image.png)

- software 안에서 구성요소가 너무 커지게 하면안된다.
- class를 사용하기전에 class를 사용하지 않는 방법을 고려해 봐라


<br>

## Reference

- https://www.youtube.com/watch?v=p3zo4ptMBiQ