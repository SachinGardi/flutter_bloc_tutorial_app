import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/ui/cart.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/ui/widhlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current)=>current is HomeActonState,
      buildWhen: (previous, current)=> current is !HomeActonState,
      listener: (context, state) {
        if(state is HomeNavigateToCartPageActionState){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Cart(),));
        }
       else if(state is HomeNavigateToWishlistPageActionState){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Wishlist(),));
        }

       else if(state is HomeProductItemAddedToCartActionState){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item added to Cart')));
        }
       else if(state is HomeProductItemWishListedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item added to wishlist')));
        }
      },
      builder: (context, state) {
       switch(state.runtimeType){
         case HomeLoadingState:
          return const Scaffold(
            body: Center(
              child:  CircularProgressIndicator(),
            ),
          );
         case HomeLoadedSuccessState:
           final successState = state as HomeLoadedSuccessState;
           return Scaffold(
             appBar: AppBar(
               backgroundColor: Colors.teal,
               title: const Text('Sachin\'s Grocery app'),
               centerTitle: true,
               actions: [
                 IconButton(onPressed: (){
                   homeBloc.add(HomeWishlistButtonNavigateEvent());
                 }, icon: const Icon(Icons.favorite_border)),
                 IconButton(onPressed: (){
                   homeBloc.add(HomeCartButtonNavigateEvent());
                 }, icon: const Icon(Icons.shopping_bag_outlined)),
               ],
             ),
             body: ListView.builder(
                 itemCount: successState.products.length,
                 itemBuilder: (context, index) {
                   return ProductTileWidget(productDataModel: successState.products[index],homeBloc: homeBloc,);
                 },
             ),
           );

         case HomeErrorState:
           return const Scaffold(
             body: Center(child: Text('Error'),),
           );
         default:
           return const SizedBox();
       }
      },
    );
  }
}

