![](https://velog.velcdn.com/images/qnm83/post/c8e749fd-af96-4cb7-9bcb-49557595e129/image.png)

- Buttons
- Button configuration
- Toggle buttons
- Pop-up buttons
- Menus

## Buttons

![](https://velog.velcdn.com/images/qnm83/post/183501cc-d9c2-417e-97e4-517d59981a25/image.png)

- 이제 4가지 스타일 제공함

![](https://velog.velcdn.com/images/qnm83/post/52a88a9d-ba41-420d-a9b0-78ddfeba7f21/image.png)

- Dynamic type default로 지원
- Multiline 가능
- Accessibility 증가 
- 커스텀하기 쉬움

<br>

## Button configurtaion

![](https://velog.velcdn.com/images/qnm83/post/afcf18d0-897b-4e0a-8906-506e27799c46/image.png)

- 기존의 코들를 업데이트 하지 않고도 configuration 사용해 쉽게 업데이트 가능

![](https://velog.velcdn.com/images/qnm83/post/16b3e4a3-97bb-4572-913d-f3efa0125153/image.png)

- imagae 위치 설정 가능
- subtitle 추가

![](https://velog.velcdn.com/images/qnm83/post/5e0295d5-fffc-4255-854f-d4002447765b/image.png)

- cnofigurationUpdateHandler 사용해 특정이벤트에 업데이트 가능
- 버튼이 눌렸을 때 업데이트

![](https://velog.velcdn.com/images/qnm83/post/505d4ea5-6190-404b-af0c-7b8f6445859c/image.png)
![](https://velog.velcdn.com/images/qnm83/post/4a305c00-a501-414a-bc6f-171964c2e775/image.png)

- setNeedsUpdateConfiguration 사용해 업데이트가 필요한 시점에 업데이트 가능
- didSet 사용해 itemQuantityDescription 값이 변경되면 버튼의 subtitle 업데이트 해준다.

![](https://velog.velcdn.com/images/qnm83/post/624c5d71-9cec-4306-9201-08730dacf207/image.png)

- activity indicator 보여주기 가능

![](https://velog.velcdn.com/images/qnm83/post/6d2a1d35-f80d-4423-8f12-4b02c81e3952/image.png)

- contentInsets, titlePadding, imagePadding 설정 가능


![](https://velog.velcdn.com/images/qnm83/post/83021eb1-b70e-4d6e-a170-759ae3f06fa4/image.png)

- semantic styling은 버튼을 쉽게 만들게 해준다.


<br>

## Toggle buttons


![](https://velog.velcdn.com/images/qnm83/post/f40bec91-52d0-455d-8287-d767acef6653/image.png)

- 선택된 상태를 유지함 
- 코드로도 설정 가능
- On & Off 상태 configuration으로 설정 가능

- bar button item에서도 사용 가능

![](https://velog.velcdn.com/images/qnm83/post/d64f04eb-d8e1-466a-81ab-7afa7727b88a/image.png)

- changesSelectionAsPrimaryAction = true로 설정해주면 toggle button


<br>

## Pop-up buttons

![](https://velog.velcdn.com/images/qnm83/post/ec8a0af9-6f97-43ff-b173-f5f19f3b5905/image.png)

- pull down button과 비슷하다.
- 1개 선택된 상태로 시작 가능

![](https://velog.velcdn.com/images/qnm83/post/69299a04-5509-45c2-9b8e-a3a9c9fee354/image.png)


![](https://velog.velcdn.com/images/qnm83/post/a97a2f0c-408e-4d92-9146-e342834f4cec/image.png)

- 선택된 메뉴 확인 가능

![](https://velog.velcdn.com/images/qnm83/post/4c640b88-b57c-4d8a-8805-1e7dec1763a8/image.png)

- 코드로 state 변경 가능
- UIAction의 state를 .on으로 설정하면 default selected로 설정 가능


![](https://velog.velcdn.com/images/qnm83/post/34ecead1-de14-497d-807c-efd0cfea00d4/image.png)

- interface Builder에서도 생성 가능


<br>

## Mac Catalyst

![](https://velog.velcdn.com/images/qnm83/post/5cbc35a8-ef93-4437-9db5-23fc95031cc4/image.png)


Mac Catalyst에서 자동으로 작동한다.

![](https://velog.velcdn.com/images/qnm83/post/f07530cc-43da-4685-8d92-e8ff3df82256/image.png)

- style automatic 말고 pad 등으로 강제 설정도 가능

<br>

## UIMenu

![](https://velog.velcdn.com/images/qnm83/post/e90ddddc-0ed0-4986-9f57-3e0b0a2b8337/image.png)

- button, barbutton 과 자주 함께 사용됨
- subtitle(submenu에서만 보임) 
- 서브 메뉴 추가 가능
- 선택된 항목 확인 가능

```swift
sortSelectionButton.menu?.selectedElements.first
```

<br>

## 참고

- https://developer.apple.com/videos/play/wwdc2021/10064/