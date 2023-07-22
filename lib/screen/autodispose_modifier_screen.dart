import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ex/layout/default_layout.dart';
import 'package:riverpod_ex/riverpod/autodispose_modifier.dart';

class AutodisposeModifierScreen extends ConsumerWidget {
  const AutodisposeModifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autodisposeModifierProvider);

    return DefaultLayout(
        title: 'AutodisposeModifierScreen',
        body: Center(
          child: state.when(
            data: (data) => Text(data.toString()),
            error: (err, stack) => Text(err.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
        ));
  }
}
