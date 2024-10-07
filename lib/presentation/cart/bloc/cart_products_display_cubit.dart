import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/domain/order/entities/product_ordered.dart';
import 'package:online_shop/domain/order/usecases/get_cart_products.dart';
import 'package:online_shop/domain/order/usecases/remove_cart_product.dart';
import 'package:online_shop/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:online_shop/service_locator.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit() : super(CartProductsLoading());

  void displayCartProducts() async {
    var returnedData = await sl<GetCartProductsUseCase>().call();

    returnedData.fold((error) {
      emit(LoadCartProductsFailure(errorMessage: error));
    }, (data) {
      emit(CartProductsLoaded(products: data));
    });
  }

  Future<void> removeProduct(ProductOrderedEntity product) async {
    emit(CartProductsLoading());
    var returnedData =
        await sl<RemoveCartProductUseCase>().call(params: product.id);

    returnedData.fold((error) {
      emit(LoadCartProductsFailure(errorMessage: error));
    }, (data) {
      displayCartProducts();
    });
  }
}
