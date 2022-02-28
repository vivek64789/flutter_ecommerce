part of 'admin_product_bloc.dart';

@immutable
class AdminProductState {
  final String id;
  final String product;
  final String picture;

  AdminProductState({this.id, this.product, this.picture});

  AdminProductState copyWith({String id, String product, String picture}) =>
      AdminProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        picture: id ?? this.picture,
      );
}

// --------------------------------------------------//
class AddProductState extends AdminProductState {}

class LoadingAddProductState extends AdminProductState {}

class AddProductSuccessState extends AdminProductState {}

class FailureAddProductState extends AdminProductState {
  final String error;

  FailureAddProductState({this.error});
}

// -------------------------------------------------//
class LoadingUpdateProductState extends AdminProductState {}

class UpdateProductSuccessState extends AdminProductState {}

class FailureUpdateProductState extends AdminProductState {
  final String error;

  FailureUpdateProductState({this.error});
}

// --------------- delete state -------------------
class DeleteProductLoadingState extends AdminProductState {}

class DeleteProductSuccessState extends AdminProductState {}

class DeleteProductFailureState extends AdminProductState {
  final String error;

  DeleteProductFailureState({this.error});
}

// --------------- get Product details by id state -------------------
class GetProductByIdLoadingState extends AdminProductState {}

class GetProductByIdSuccessState extends AdminProductState {}

class GetProductByIdFailureState extends AdminProductState {
  final String error;

  GetProductByIdFailureState({this.error});
}
