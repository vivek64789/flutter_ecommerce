import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commers/Controller/AdminController.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:meta/meta.dart';

part 'admin_product_event.dart';
part 'admin_product_state.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  AdminProductBloc() : super(AdminProductState());

  @override
  Stream<AdminProductState> mapEventToState(AdminProductEvent event) async* {
    if (event is AddProductEvent) {
      yield* _mapAddProduct(
        event.product,
      );
    } else if (event is UpdateProductEvent) {
      yield* _mapUpdateProduct(event.product);
    } else if (event is DeleteProductEvent) {
      yield* _mapDeleteProduct(event.id);
    } else if (event is GetProductDetailsByIdEvent) {
      yield* _mapGetProductById(event.id);
    }
  }

  Stream<AdminProductState> _mapAddProduct(
      Product product) async* {
    try {
      yield LoadingAddProductState();
      await Future.delayed(Duration(seconds: 1));
      final data = await adminController.addProduct(
          product: product);

      if (data.resp)
        yield AddProductSuccessState();
      else
        yield FailureAddProductState(error: data.msj);
    } catch (e) {
      yield FailureAddProductState(error: e.toString());
    }
  }

  Stream<AdminProductState> _mapUpdateProduct(
      Product product) async* {
    try {
      yield LoadingUpdateProductState();
      await Future.delayed(Duration(seconds: 2));

      final data = await adminController.updateProduct(
          product: product);

      if (data.resp) {
        yield UpdateProductSuccessState();
      } else {
        yield FailureUpdateProductState(error: data.msj);
      }
    } catch (e) {
      yield FailureUpdateProductState(error: e.toString());
    }
  }

  Stream<AdminProductState> _mapDeleteProduct(String id) async* {
    try {
      yield DeleteProductLoadingState();
      await Future.delayed(Duration(seconds: 2));

      final data = await adminController.deleteProduct(id: id);
      if (data.resp) {
        yield DeleteProductSuccessState();
      } else {
        yield DeleteProductFailureState(error: data.msj);
      }
    } catch (e) {
      yield DeleteProductFailureState(error: e.toString());
    }
  }

  Stream<AdminProductState> _mapGetProductById(String id) async* {
    try {
      yield GetProductByIdLoadingState();
      await Future.delayed(Duration(seconds: 2));

      final data = await adminController.getProductById(id: id);
      if (data.resp) {
        yield GetProductByIdSuccessState();
      } else {
        yield GetProductByIdFailureState(error: data.msj);
      }
    } catch (e) {
      yield GetProductByIdFailureState(error: e.toString());
    }
  }
}
