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

## 4. StateNotifierProvider 실습
<details>
<summary> 내용 보기</summary>
<br>

- 가장 많이 사용되는 형태의 Provider
- StateNotifierProvider 는 class 로 선언해야 한다.
- StateNotifier 을 꼭 상속받아야 한다.
- StateNotifier 의 제네릭에는 상태 관리할 타입이 어떤타입인지 지정해줘야한다.
- 생성자의 super 값 에는 state 를 처음에 어떻게 초기화 할지 넣어줘야한다. ( 제네릭의 타입과 일치해야함 )
- 즉, 다른 Provider 와는 다르게 super 안에서 state 를 초기화 한다.

    ```
        class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
            ShoppingListNotifier()
            : super(
                    [
                        ShoppingItemModel(
                            name: '김치',
                            quantity: 3,
                            hasBought: false,
                            isSpicy: true,
                        ),
                        ShoppingItemModel(
                            name: '라면',
                            quantity: 5,
                            hasBought: false,
                            isSpicy: true,
                        ),
                        ShoppingItemModel(
                            name: '삼겹살',
                            quantity: 8,
                            hasBought: false,
                            isSpicy: false,
                        ),
                        ShoppingItemModel(
                            name: '수박',
                            quantity: 2,
                            hasBought: false,
                            isSpicy: false,
                        ),
                        ShoppingItemModel(
                            name: '카스테라',
                            quantity: 1,
                            hasBought: false,
                            isSpicy: false,
                        )
                    ],
                );
        }
    ```
- StateNotifierProvider 내부에서 state 를 사용하면 초기화 된 state 를 사용할수 있다. ( extends StateNotifier 에서 제공하는 값 )

    ```
        void toggleHasBought({required String name}) {
            state = state
                .map((e) => e.name == name
                    ? ShoppingItemModel(
                        name: e.name,
                        quantity: e.quantity,
                        hasBought: !e.hasBought,
                        isSpicy: e.isSpicy)
                    : e)
                .toList();
        }
    ```
- 이 StateNotifier 를 Provider 로 제공할땐 아래와 같이 사용한다.
- StateNotifierProvider 의 첫번째 제네릭엔 내가 만든 StateNotifier 를 넣는다.
- StateNotifierProvider 의 두번째 제네릭엔 state 의 타입을 넣는다.
- 그리고 StateNotifier 를 return 한다.

    ```
        final shoppingListProvider =
            StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
                (ref) => ShoppingListNotifier()
            );
    ```
- 사용법은 다른 Provider 들과 같다.

    ```
        ref.read()
        ref.watch()
    ```
- ref.read(somthing.notifier) 은 인스턴스와 같다.

    ```
        // 클래스 내부 메서드 사용 가능

        ref.read(shoppingListProvider.notifier).toggleHasBought(name: e.name);
    ```
</details>

## 5. FutureProvider 실습
<details>
<summary> 내용 보기</summary>
<br>

- 일반 Provider 와 같은 방식으로 만들수 있다.

    ```
        final multiplesFutureProvider = FutureProvider<List<int>>(
            (ref) async {
                await Future.delayed(
                const Duration(seconds: 2),
                );

                return [1, 2, 3, 4, 5];
            },
        );
    ```
- FutureProvider 의 return 타입은 AsyncValue 이기 때문에 when() 메서드를 사용할수 있다.
- when() 메서드는 data, error, loading 으로 나뉘어져 AsyncValue 의 상태에 따라 화면에 렌더링 할것들을 설정할수 있다.

    ```
        state.when(
            data: (data) {
                return Text(data.toString());
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(
                child: CircularProgressIndicator(),
            ),
        )
    ```
</details>

## 6. StreamProvider 실습
<details>
<summary> 내용 보기</summary>
<br>

- FutureProvider 와 같은 방식으로 만들수 있다. ( 대부분의 provider 는 state 를 return 해주는 형식이다. )

    ```
        final multipleStreamProvider = StreamProvider<List<int>>((ref) async* {
            for (int i = 0; i < 10; i++) {
                await Future.delayed(const Duration(seconds: 2));

                yield List.generate(3, (index) => index * i);
            }
        });
    ```
- StreamProvider 의 return 타입은 AsyncValue 이기 때문에 when() 메서드를 사용할수 있다.
- when() 메서드는 data, error, loading 으로 나뉘어져 AsyncValue 의 상태에 따라 화면에 렌더링 할것들을 설정할수 있다.
    ```
        state.when(
          data: (data) => Text(data.toString()),
          error: (err, stack) => Text(err.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
    ```
</details>

## 7. Family Modifier 실습
<details>
<summary> 내용 보기</summary>
<br>

- Modifier 에는 family 와 autoDispose 2종류가 있다.
- Provider 뒤에 붙여서 사용할수 있다.
- 주로 Provider 로직 안에 다른 인자를 추가하여 return 할때 modifier 를 사용한다.
- Provider 의 타입 뒤에 추가하려는 인자의 타입과 data 인자를 추가하여 사용한다.

    ```
        final familyModifierProvider = FutureProvider.family<List<int>, int>(
            (ref, data) async {
                await Future.delayed(
                const Duration(seconds: 2),
                );

                return [1, 2, 3, 4, 5];
            },
        );
    ```
</details>
