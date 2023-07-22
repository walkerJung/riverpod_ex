import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyModifierProvider = FutureProvider.family<List<int>, int>(
  (ref, data) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return [1, 2, 3, 4, 5];
  },
);
