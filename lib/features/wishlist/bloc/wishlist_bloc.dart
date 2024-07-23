import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/data/wishlist_item.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
   on<WishlistInitialEvent>(wishlistInitialEvent);
   on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);

  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItem: wishlistItems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.wishlistItem);
    emit(WishlistRemoveActionState());
    Future.delayed(const Duration(milliseconds: 500));
    emit(WishlistSuccessState(wishlistItem: wishlistItems));
  }
}
