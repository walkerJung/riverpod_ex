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