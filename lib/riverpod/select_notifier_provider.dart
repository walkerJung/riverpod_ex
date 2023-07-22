import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ex/model/shopping_item_model.dart';

final selectNotifierProvider =
    StateNotifierProvider<selectNotifier, ShoppingItemModel>((ref) {
  return selectNotifier();
});

class selectNotifier extends StateNotifier<ShoppingItemModel> {
  selectNotifier()
      : super(
          ShoppingItemModel(
            name: '드루이드',
            quantity: 10,
            hasBought: false,
            isSpicy: true,
          ),
        );

  toggleHasBought() {
    state = state.copyWith(hasBought: !state.hasBought);
  }

  toggleIsSpicy() {
    state = state.copyWith(isSpicy: !state.isSpicy);
  }
}
