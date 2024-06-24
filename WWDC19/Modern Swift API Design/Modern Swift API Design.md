# Modern Swift API Design

## API Design Guidelines
> [API Design Guidelines🔗](https://www.swift.org/documentation/api-design-guidelines/)

### Clarity at the point of use


- No Prefixes in Swift-only Frameworks
  - C and Objective-C symbols are global
- Swift modul system allows disambiguation
- each source file brings its imports into the same namespace

<br>

- Values and references
- Protocols and generics
- Key path member lookup
- Property wrappers

## Values and references

### 3가지 타입 생성 방법 
> class, struct, enum

- Reference Types

![alt text](image.png)

- Value Types
  - Value Type을 사용하면 그 값이 어디에서 왔고 변경되지는 않을지 걱정하지 않아도 된다.

![alt text](image-1.png)

<br>

### Choosing - Reference or Value?

![alt text](image-3.png)

- the value is held centrally and shared
> you'll want to wrap that class inside a struct as we'll see shortly
> struct 안에 class가 존재하는 상황

- Where there is a separate notion of "identity" from "equality"  
  - identity: 같은 메모리 영역을 가르키는지
  - equality: 같은 값을 갖는지

<br>

![alt text](image-2.png)

- Entity들은 realityKit engine 내부에 centrally 하게 저장됨
- identity를 갖음
- 물체의 모양을 바꾸거나 주변 장면을 조작하면 엔진에서 직접 물체를 조작한다.
  - RealityKit에 저장된 실제 물체에 대한 handling을 참조유형이라 생각할 수 있습니다.

<br>

- entity 내부의 location, orientation 들은 value type입니다.

![alt text](image-4.png)


![alt text](image-5.png)

- material은 value 타입이라 이전 코드에 영향을 미치지 않음
- 변경으로 인한 사고 방지 가능 

![alt text](image-6.png)

![alt text](image-7.png)

- value 타입 내부에 reference 타입이 있는경우 reference 타입 값을 공유해 문제가 발생할 수 있다.


