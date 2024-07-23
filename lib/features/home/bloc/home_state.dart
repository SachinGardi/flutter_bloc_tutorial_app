part of 'home_bloc.dart';

@immutable
sealed class HomeState {}


abstract class HomeActonState extends HomeState{}

final class HomeInitial extends HomeState {}


class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessState extends HomeState{
  final List<ProductDataModel> products;
  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState{}

class HomeNavigateToWishlistPageActionState extends HomeActonState{}

class HomeNavigateToCartPageActionState extends HomeActonState{}

class HomeProductItemWishListedActionState extends HomeActonState{}

class HomeProductItemAddedToCartActionState extends HomeActonState{}

