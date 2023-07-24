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
- 주로 Provider 로직 안에 다른 인자를 추가하여 state 를 수정할때 modifier 를 사용한다.
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

## 8. AutoDispose Modifier 실습
<details>
<summary> 내용 보기</summary>
<br>

- autoDispose 는 자동으로 캐시를 삭제하고 싶을때 사용한다.

</details>

## 9. Listen 함수 실습
<details>
<summary> 내용 보기</summary>
<br>

- stateful 위젯에서 provider 를 사용하려는 경우 ConsumerStatefulWidget, ConsumerState 로 변경해주면 된다.

    ```
        class ListenProviderScreen extends ConsumerStatefulWidget {}
        class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen> {}
    ```
- ConsumerState 는 두번째 인자로 WidgetRef 를 받지 않아도 this.ref 로 글로벌 하게 사용할수 있다.
- controller 에서 vsync 를 사용할때는 with TickerProviderStateMixin 후 this 를 전달한다.

    ```
        class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen> with TickerProviderStateMixin {
            late final TabController _tabController;

            @override
            void initState() {
                super.initState();

                _tabController = TabController(length: 10, vsync: this);
            }
        }
    ```
- listen 함수는 state 의 변경 전 값 (previous) 와 변경 후 값 (next) 를 알수 있다.
- listen 함수의 제네릭은 previous 와 next 의 타입을 정해주면 된다.

    ```
        ref.listen<int>(listenProvider, (previous, next) {});
    ```
- state 값을 update 해주는 이벤트를 추가하고 listen 함수 바디부분에서 animatedTo(next) 로 화면 전환을 구현하였다.

    ```
        ref.listen<int>(listenProvider, (previous, next) {
            if(previouse != next) animatedTo(next);
        });

        onPressed(){
            ref.read(listenProvider.notifier).update((state) => state != 10 ? state + 1 : 10);
        }
    ```
- listen 함수는 dispose 를 하지 않아도 되도록 설계되어 있다.
- initState 내부에선 watch 를 사용할수 없고, 단발적인 메서드들만 사용해야한다.

    ```
        void initState() {
            super.initState();

            _tabController = TabController(
                length: 10,
                vsync: this,
                initialIndex: ref.read(listenProvider),
            );
        }
    ```
</details>

## 10. Select 실습
<details>
<summary> 내용 보기</summary>
<br>

- ShoppingItemModel 에 copyWith 함수를 추가해서 필요한 필드만 변경할수 있도록 한다.
- ref.watch 를 하고있으면 필드가 변경될때 다시 빌드된다.
- select 는 보통 최적화 하기 위해 사용한다.
- select 한 value 가 변경될때만 빌드가 된다.

</details>

## 11. Provider안에 Provider 사용하기
<details>
<summary> 내용 보기</summary>
<br>

- Provider 안에 기존에 만들어둔 Provider 를 선언할수 있다. 주로 watch 를 많이 사용한다.

    ```
        final filteredShoppingListProvider = Provider(
          (ref) => ref.watch(shoppingListProvider),
        );
    ```
- 위와 같이 부모 자식 관계의 Provider 에서 자식 Provider 로 접근하여 state 를 변경하더라도, 부모 Provider 를 watch 하고있는 위젯이 다시 build 된다.

    ```
        // 부모 Provider watch        
       final state = ref.watch(filteredShoppingListProvider);   

        
        // 자식 Provider 를 변경하는 event
       onChanged: (value) {
            ref
                .read(shoppingListProvider.notifier)
                .toggleHasBought(name: e.name);
        }, 
    ```
- appBar 의 actions 속성에 PopupMenuItem() 을 추가하면 오른쪽 상단에 팝업 관련 UI 를 추가할수 있다

    ```
       actions: [
        PopupMenuButton<FilterState>(
          itemBuilder: (_) => FilterState.values
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onSelected: (value) {
            ref.read(filterProvider.notifier).update((state) => value);
          },
        ),
      ], 
    ```
- Provider 속에서 여러가지 Provider 를 watch 하면서 로직을 구현할수 있다.

    ```
        final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
            (ref) {
                final filterState = ref.watch(filterProvider);
                final shoppingListState = ref.watch(shoppingListProvider);

                if (filterState == FilterState.all) {
                return shoppingListState;
                }

                return shoppingListState
                    .where((element) => filterState == FilterState.spicy
                        ? element.isSpicy
                        : !element.isSpicy)
                    .toList();
            },
        );
    ```
</details>

## 12. ProviderObserver 실습
<details>
<summary> 내용 보기</summary>
<br>

- ProviderObserver 는 Provider 를 관찰하는 역할을 한다.
- 주로 logger 로 많이 사용한다.


</details>

<br><br>

# Riverpod v2

## 1. Riverpod v2 코드제너레이션 소개
<details>
<summary> 내용 보기</summary>
<br>

- CodeGeneration 을 사용하려면 part '~.g.dart' 를 선언해주어야 한다.

    ```
        part 'code_generation_provider.g.dart';
    ```
- @riverpod 어노테이션을 사용해서 provider 를 만들수 있다.
- 첫번째 인자값은 무조건 ref 가 들어가는데 타입은 선언한 함수명 앞글자를 대문자로 바꿔주면 된다.

    ```
        @riverpod
        String gState(GstateREf ref) {
            return 'Hello Code Generation';
        }
    ```
- .g.dart 파일을 확인해보면 gState 뒤에 자동으로 Provider 이 붙어서 Provider 가 생성된걸 확인할수 있다.
</details>

## 2. Riverpod v2 KeepAlive 세팅하기
<details>
<summary> 내용 보기</summary>
<br>

- .g.dart 파일을 분석해보면 autoDispose 로 Provider 가 생성된걸 알수 있다.
- 즉, 일반적으로 generation 을 사용해 만들면 캐시처리가 안된다.
- 캐시 처리를 하고싶다면 @Riverpod() 어노테이션을 사용해서 KeepAlive 속성에 true 를 넣어주면 된다.

    ```
        @Riverpod(keepAlive: true)
        Future<int> gStateFuture2(GStateFuture2Ref ref) async {
            await Future.delayed(const Duration(seconds: 3));
            return 10;
        }
    ```
</details>

## 3. Riverpod v2 Family로 파라미터 전달받기
<details>
<summary> 내용 보기</summary>
<br>

- generation 을 사용하면 family 의 데이터를 일반함수 파라미터처럼 받을수 있다.
    ```
        @riverpod
        int gStateMultyply(GStateMultyplyRef ref,
            {required int number1, required int number2}) {
            return number1 * number2;
        }

        final state4 = ref.watch(gStateMultyplyProvider(number1: 5, number2: 2));
    ```

</details>

## 4. Riverpod v2 StateNotifierProvider 코드제너레이션으로 생성하기
<details>
<summary> 내용 보기</summary>
<br>

- generation 을 사용하여 stateNotifier 를 만들때 build 메서드만 오버라이드 해주면 된다

    ```
        @riverpod
        class GStateNotifier extends _$GStateNotifier {
            @override
            int build() {
                return 0;
            }

            increment() {
                state++;
            }

            decrement() {
                state--;
            }
        }
    ```
</details>

## 5. Riverpod v2 Invalidate 함수
<details>
<summary> 내용 보기</summary>
<br>

- invalidate 함수는 원하는 state 를 초기값으로 변환하는 함수이다.

    ```
        ElevatedButton(
            onPressed: () {
                ref.invalidate(gStateNotifierProvider);
            },
            child: const Text('Invalidate'),
        )
    ```
</details>

## 6. Riverpod v2 Consumer 위젯 사용하기
<details>
<summary> 내용 보기</summary>
<br>

- 부모 위젯이 build 되면 자식위젯도 build 되지만, 자식 위젯이 build 될때 부모 위젯은 build 되지 않는다.
- riverpod 의 Consumer 위젯을 사용하면 부모의 build 메서드가 아닌 Consumer 위젯의 builder 메서드가 새로 실행된다. 즉, 자식 위젯만 다시 build 되는 효과를 줄수 있다.
- 렌더링 효율을 위해 주로 사용한다.
- child 속성은 딱 한번만 렌더링 된다. 즉, builder 메서드가 실행되도 다시 랜더링 되지 않는다.
- 렌더링 하는데 많은 퍼포먼스가 들어가는 위젯들을 child 로 넘겨주면 좋다.
- const 와 비슷한 개념이다
</details>





