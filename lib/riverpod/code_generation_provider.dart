import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 Provider 를 사용할지 결정할 고민 할 필요 없도록

final _testProvider = Provider<String>((ref) => 'hello Code Generation');

@riverpod
String gState(GStateRef ref) {
  return 'Hello Code Generation';
}


// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록