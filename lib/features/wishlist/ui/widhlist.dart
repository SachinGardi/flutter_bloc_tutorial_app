import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/ui/wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('WishlistItem'),
          centerTitle: true,
        ),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc:wishlistBloc,
          buildWhen: (previous, current) => current is !WishlistActionState,
          listenWhen: (previous, current) => current is WishlistActionState,
          listener: (context, state) {
            if(state is WishlistRemoveActionState){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Wishlist removed Successfully'),
                duration: Duration(milliseconds: 1000),
              ));
            }
          },
          builder: (context, state) {

            switch(state.runtimeType){
              case WishlistSuccessState:
                final successState = state as WishlistSuccessState;
                return ListView.builder(
                    itemCount: successState.wishlistItem.length,
                    itemBuilder: (context, index) => WishListTileWidget(
                        productDataModel:successState.wishlistItem[index],
                        wishlistBloc: wishlistBloc
                    ),


                );
            }
            return Container();
          },
        ),
    );
  }
}
