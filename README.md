# Riverpod을 이용한 상태관리

## 1. Riverpod 소개
<details>
<summary> 내용 보기</summary>
<br>

- main.dart 의 runApp 부분을 ProviderScope 로 감싸준다.
    ```
        void main(){
            runApp(const ProviderScope(
                    child: MyApp()
                )
            )
        }
    ```
- 관리할 상태를 StateProvider 를 통해서 만든다.

    ```
        final numberProvider = StateProvider<int>((ref) => 0);            
    ```
- 상태를 사용하고 싶은 위젯을 ConsumerWidget 으로 바꿔준다.

    ```
       class StateProviderScreen extends ConsumerWidget {} 
    ```
- ConsumerWidget 은 WidgetRef 를 사용해야 한다.

    ```
       Widget build(BuildContext context, WidgetRef ref) {} 
    ```
- 상태를 확인 및 변경하기 위해 ref 의 메서드를 사용한다.

    ```
        ref.watch(numberProvider);
        ref.read(numberProvider.notifier).update((state) => state + 1);
    ```
</details>

## 2. Riverpod 이론
<details>
<summary> 내용 보기</summary>
<br>

- 다양한 타입을 리턴하는 provider 들이 존재한다.
    ```
        - Provider
        - StateProvider
        - StateNotifierProvider
        - FutureProvider
        - StreamProvider        
    ```
- 각각 다른 타입을 반환해주고 사용 목적이 다르다.
- 모든 Provider 는 글로벌 하게 선언되므로 어디서 선언하든 사용할수 있다.
- ref.watch 는 반환값의 업데이트가 있을때 지속적으로 build 함수를 다시 실행해준다.
- ref.watch 는 필수적으로 UI 관련 코드에만 사용한다.
- ref.read 는 실행되는 순간 단 한번만 provider 값을 가져온다.
- ref.read 는 onPressed 콜백처럼 특정 액션 뒤에 실행되는 함수 내부에서 사용된다.
</details>

## 3. StateProvider 실습
<details>
<summary> 내용 보기</summary>
<br>

- update 시키는 방법 외에 state 자체에 state 값을 변경해서 할당시켜줄수 있다.

    ```
        ref.read(numberProvider.notifier).state = ref.read(numberProvider.notifier).state - 1;
    ```
</details>