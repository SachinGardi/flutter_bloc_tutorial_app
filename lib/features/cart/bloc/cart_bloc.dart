import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/data/cart_items.dart';
import 'package:meta/meta.dart';
import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
   on<CartInitialEvent>(cartInitialEvent);
   on<CartRemoveFromCart>(cartRemoveFromCart);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
      emit(CartSuccessState(cartItems: cartItem));
  }

  Future<FutureOr<void>> cartRemoveFromCart(CartRemoveFromCart event, Emitter<CartState> emit) async {
    cartItem.remove(event.productDataModel);
    emit(CartRemoveActionState());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(CartSuccessState(cartItems: cartItem));
  }
}
