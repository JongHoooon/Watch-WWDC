# Your guide to keyboard layout

## Layout guide

### UIKeyboarLayoutGuide

- notification을 사용했을 때
![Alt text](image-1.png)

<br>

- 이제는 notification 사용하지 않고 코드 한 줄이면 됨
 ![Alt text](image.png)

### Updating to keyboard layout guide 
 
- Use `view.keyboardLayoutGuide`
<p align="left"><img width="200" src="image-2.png"></p>

- Basic case: update to use .topAnchor
- Matches animations
<p align="left"><img width="200" src="image-3.png"></p>

- Follows height changes
<p align="left"><img width="200" src="image-4.png"></p>  

- Bottom of safe area when undocked
  - 키보드가 undocked 상태일 때 guide는 safe-layout insets을 고려해 screen의 바닥으로 떨어진다.
  - width는 window의 width가 된다.
<p align="left"><img width="200" src="image-6.png"></p>

 <br>

---

<br>

## Integrating the keyboard

### Avoiding "avoidance"
> UI Keyboard Layout의 핵심 동기중 하나는 사용자가 텍스트를 입력할 수 있는 다양한 방식에 대응할 수 있게 해주기 위함입니다.

- The keyboard is a part of your app
- Your layout should reflect

<br>

### Follow the leader

- `.followsUndockedKeyboard`
  - default는 false
- As the keyboard moves, the guide moves
  - true로 설정하면 keyboard가 undocked or floating 상태일 때 guide가 keyboard를 따라가서 keyboard가 어디에 있든지 layout이 어떻게 반응할지 대한 많은 통제권을 얻을 수 있습니다.
- No more automatic drop-to-bottom
  - 더 이상 자동으로 내려가지 않습니다.
  - undocking시 hide keyboard notification을 들을 수 없습니다.
  - layout guide는 keyboard의 위치입니다.

<br>

### UITrackingLayoutGuide
> UIKeyboardLayoutGuide는 UITrackingLayoutGuide의 subclass 입니다.

- A layout guide that tracks constraints that need to change
- Specify constraints activate when `near` a specific edge
- Specify constraints activate when `awayFrom` a specific edge

![Alt text](image-9.png)

- awayFromTopConstraints

top edge에서 멀어질 때 edit view는 keyboard위에 붙어있음

![Alt text](image-12.png)

![Alt text](image-10.png)

- nearTopConstraints

top edge에 가까워질 때 edit view는 safeAreaLayoutGuide bottom에 붙어있음

![Alt text](image-13.png)

![Alt text](image-11.png)

- awayFromSides

![Alt text](image-14.png)

- nearTrailingConstraints, nearLeadingConstraints

![Alt text](image-15.png)

![Alt text](image-16.png)

<br>

### mean of near and awayFrom 

- docked keyboard

![Alt text](image-17.png)

- undocked and split keyboards

![Alt text](image-18.png)

![Alt text](image-32.png)

모든 edges에서 awayFrom할 수 있거나 top edge로 near할 수 있다.

- Floating

![Alt text](image-19.png)

모든 edges에서 awayFrom, near 가능

![Alt text](image-20.png)

2 edges에 동시에 near되는 상황에 충돌 주의!

<br>

---

<br>

## Types of keyboards

### Floating Keyboard behaviors

- Can be `awayFrom` everything

![Alt text](image-21.png)

- Can be very near to top

![Alt text](image-22.png)

- Set constraints when awayFrom bottom

![Alt text](image-23.png)

- Can be moved any where specific

<br>

### Split and undocked keyboard behaviors

![Alt text](image-24.png)

- 모든 edge들에서 awayFrom 가능

- Can be `near` top
- Always `awayFrom` leading/trailing
- Undocked keyboard is `awayFrom` bottom

<br>

### Text input via camera

![Alt text](image-26.png)

- Same as docked keyboard
- Can be full screen

<br>

### Hardware Keyboard

![Alt text](image-28.png)

- Shortcuts bar
- Width is adaptive
- Always `near` bottom

![Alt text](image-29.png)

- Can be `near` leading or trailing when collapsed

![Alt text](image-30.png)

### Multitasking behaviors

- Same as dismissed when out of app window  
- When narrow, `awayFrom` leading and trailing  

![Alt text](image-31.png)

- Guide is sized for app window

<br>

## Reference

- https://developer.apple.com/videos/play/wwdc2021/10259/