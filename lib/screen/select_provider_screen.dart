import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ex/layout/default_layout.dart';
import 'package:riverpod_ex/riverpod/select_notifier_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(selectNotifierProvider.select((value) => value.isSpicy));
    print("build");
    return DefaultLayout(
      title: 'SelectProviderScreen',
      body: Column(
        children: [
          Text(state.toString()),
          ElevatedButton(
            onPressed: () {
              ref.read(selectNotifierProvider.notifier).toggleHasBought();
            },
            child: const Text('change Bought'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(selectNotifierProvider.notifier).toggleIsSpicy();
            },
            child: const Text('change Spicy'),
          ),
        ],
      ),
    );
  }
}
