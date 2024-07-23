import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/ui/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Cart Items'),
        centerTitle: true,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc:cartBloc ,
        buildWhen: (previous, current) => current is !CartActionState,
        listenWhen: (previous, current) => current is CartActionState,
        listener: (context, state) {
          if(state is CartRemoveActionState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Item removed from cart'),
                duration: Duration(milliseconds: 1000),
            ));
          }
        },
        builder: (context, state) {

          switch(state.runtimeType){
            case CartSuccessState:
              final successState =  state as CartSuccessState;
          return ListView.builder(
          itemCount: successState.cartItems.length,
          itemBuilder: (context, index) {
          return CartTileWidget(productDataModel: successState.cartItems[index],cartBloc:cartBloc ,);
          },
          );
          }

          return Container();
        },
      ),
    );
  }
}
