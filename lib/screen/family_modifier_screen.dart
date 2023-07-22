import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ex/layout/default_layout.dart';
import 'package:riverpod_ex/riverpod/family_modifier.dart';

class FamilyModifierScreen extends ConsumerWidget {
  const FamilyModifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(familyModifierProvider(3));

    return DefaultLayout(
        title: 'FamilyModifierScreen',
        body: Center(
          child: state.when(
            data: (data) => Text(data.toString()),
            error: (err, stack) => Text(err.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
        ));
  }
}
