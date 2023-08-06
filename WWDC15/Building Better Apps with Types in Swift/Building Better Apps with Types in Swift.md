![](https://velog.velcdn.com/images/qnm83/post/2db22997-6ea5-4145-8c24-7ebb55fd4e11/image.png)

## Referenc sementics

### Unintended Sharing

![](https://velog.velcdn.com/images/qnm83/post/18112e33-d7f9-426f-908c-e4eb97d41212/image.png)

- 같은 주소를 참조해 원하지 않는 값의 변화가 발생할 수 있다.

### Manual Copy

![](https://velog.velcdn.com/images/qnm83/post/d0a21d6a-b601-49db-9934-8d82b5e80e52/image.png)

- copy() 메소드로 값만 복사할 수 있다.
- heap 영역에 할당해 cost가 크고 copy()를 실수로 하지 못하면 위험이 크다.

### Defensive Copying

![](https://velog.velcdn.com/images/qnm83/post/ac3dd14e-110a-4c2a-9668-03ea71b1e4d9/image.png)

- setter을 사용해 안전하게 값을 복사\

<br>

## Immutability

![](https://velog.velcdn.com/images/qnm83/post/2d11e5bf-aad6-4c9b-b589-26597501c031/image.png)

- 함수형 프로그래밍 언어는 immutability을 가진 reference semantic을 합니다.
- mutation을 가진 reference semantic발생하는 문제들을 제거합니다.
  - 의도하지 않은 사이드 이펙트가 없습니다.
- 주의할 단점
  - 어색한 인터페이스로 이어질 수 있습니다.
  - 불변 이라는 특성이 변화하는 실제 상황들과 잘 맞지 않을 수 있습니다.
  

### Awkward Immutable Interfaces

![](https://velog.velcdn.com/images/qnm83/post/77357139-7f5a-44d1-976d-5a147658cb86/image.png)

- 새로운 Temperature을 생성해서 주입하는 과정이 비효율적이다(heap에 새로 할당해야함)
- 진짜 불변성을 지키기 위해서는 home.oven.temperature에 새로운 값을 넣어주는게 아니라 home도 새로운 temperature와 함께 새로 만들어 줘야한다.

![](https://velog.velcdn.com/images/qnm83/post/d435e130-4988-4123-bc93-384331f74f82/image.png)

- 성능면에서 비효율적이다.

<br>

## Value Semantics

### Variables Are Logically Distinct

![](https://velog.velcdn.com/images/qnm83/post/40603cfd-7292-4ba6-9def-aabc8a22be0f/image.png)

- 값 타입은 공유가 생기지 않는다.
- Swift의 fundamental type들은 value type이다.
  - Int, Double, String..
- Swift의 collection들은 value type이다.
  - Array, Set, Dictionary
- value type을 담고있는 tuple, struct, enum 들은 value type입니다.

### Mutation When You Want it

![](https://velog.velcdn.com/images/qnm83/post/2b905000-e71e-4c74-bf16-ff0204773c0c/image.png)

- mutation도 가능
   
   
### Freedom from Race Conditions

- 다른 스레드에서 접근해도 값을 복사해가서 경쟁 상태 발생하지 않는다.

### Copies Are Cheap

![](https://velog.velcdn.com/images/qnm83/post/18a052b2-cfea-4a15-b2f2-2c591f0714d5/image.png)

- 값 타입 복사의 비용이 크지않다.
- 확장이 가능한 자료구조들은 `copy-on-write`를 사용합니다.
  - 값이 변경되기 전에는 복사된 값을 참조하고 있다가 변경이 발생했을 때 진짜 복사를 진행한다.

<br>

## Mixing Value Types and Reference Types

### Immutable References and Equatable

![](https://velog.velcdn.com/images/qnm83/post/cff1dc98-3782-4429-8e12-9e8933106617/image.png)

![](https://velog.velcdn.com/images/qnm83/post/4a3dc062-7aa7-4cb9-ab58-27300bb73b0d/image.png)

- 값 타입 안에서의 참조는 공유를 하지 않습니다.
  - image2의 image를 변경해도 image의 image는 변하지 않는다.
  
![](https://velog.velcdn.com/images/qnm83/post/05b55e85-1eed-4465-be8e-70385b35ebc3/image.png)

- 값 타입 안에 참조 타입이 있을때 Equatable을 채택해 ==를 구현하려면 ===를 사용해 같은 주소를 참조하는지 확인할 수 도있지만 변화가 발생했을 때 같은 주소를 참조하지 않아 적절하지 않습니다.

![](https://velog.velcdn.com/images/qnm83/post/9e868100-a7dd-4881-8f19-9f1db582dd89/image.png)

- isEqual 메소드를 사용해서 객체를 비교해야합니다.

### Reference to Mutable Objects

![](https://velog.velcdn.com/images/qnm83/post/b1130533-1194-4887-b9e8-d3ee1d7ae1dd/image.png)

- addLineToPoint에 의해 참조 타입의 프로퍼티에 변화가 생겨 문제가될 수 있다.
- func 앞에 mutating 키워드가 없지만 path는 참조 타입이기 때문에 컴파일러는 에러를 표시하지 않습니다.

![](https://velog.velcdn.com/images/qnm83/post/1f0d125e-4244-46d6-b033-7f6cc3d80682/image.png)

- 우리는 path에 쓰기전에 copy를 진행해야합니다.

![](https://velog.velcdn.com/images/qnm83/post/f4f53171-0bfa-4a94-a799-b163fb06a956/image.png)

1. path 인스턴스를 private로 만듭니다.
2. pathForReading: 연산 프로퍼티를 사용해 private인 path를 read합니다.
3. pathForWriting: 연산 프로퍼티를 사용해 path에 write를 할때는 mutating 키워드를 명시하고 copy()한 path를 반환합니다.

![](https://velog.velcdn.com/images/qnm83/post/92bd267e-a052-425a-b703-21bfaaaa0334/image.png)

4. pathForReading 사용해 isEmty 수정
5. pathForWriting 사용해 addLineToPoint수정, pathForWriting에 mutating이 명시됐으므로 addLineToPoint 메소드에도 mutating을 명시해줘야한다.

![](https://velog.velcdn.com/images/qnm83/post/7d4d38d7-fd67-446c-98e2-27e0f23d0def/image.png)

- 복사전에는 같은 UIBezierPath를 참조합니다.

![](https://velog.velcdn.com/images/qnm83/post/1478e196-e6c2-4975-8244-adf4c42f4704/image.png)

- addLineToPoint메소드를 사용하면 복사가 일어나 다른 UIBezierPath를 참조하게 됩니다.

### How to use in practice

![](https://velog.velcdn.com/images/qnm83/post/1cb17f6d-ed3d-429a-9f34-0397cafd6d0e/image.png)

- for문의 loop에서 매번 copy가 발생해 성능에 좋지않다.

![](https://velog.velcdn.com/images/qnm83/post/19880592-6d76-4594-9087-463ee57b0c7b/image.png)

- UIBezierPath()를 새로만들고 BezierPath 인스턴스를 새로 만들어 반환해줍니다.
- 이렇게 하면 1번의 copy만 발생합니다.

### Uniquely Referenced Swift Objects

![](https://velog.velcdn.com/images/qnm83/post/5df33fef-2b26-476a-a618-79483c021a8f/image.png)

- isUniquelyReferencedNonObjc 메소드를 사용하면 필요한 상황에만 copy()를 사용하게 최적화할 수 있습니다.

<br>

## 참고

- https://www.youtube.com/watch?v=A_b2oCBmm2Y
