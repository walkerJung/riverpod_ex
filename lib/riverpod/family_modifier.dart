import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyModifierProvider = FutureProvider.family<List<int>, int>(
  (ref, data) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return [1 * data, 2 * data, 3 * data, 4 * data, 5 * data];
  },
);
