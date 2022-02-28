part of 'admin_product_bloc.dart';

@immutable
abstract class AdminProductEvent {}

class AddProductEvent extends AdminProductEvent {
  final String product;
  final String picture;

  AddProductEvent({this.product, this.picture});
}


class UpdateProductEvent extends AdminProductEvent {
  final String product;
  final String picture;
  final String id;

  UpdateProductEvent({this.product, this.picture, this.id});
}

// delete Product
class DeleteProductEvent extends AdminProductEvent {
  final String id;
  DeleteProductEvent({this.id});
}
// get Product details by id
class GetProductDetailsByIdEvent extends AdminProductEvent {
  final String id;
  GetProductDetailsByIdEvent({this.id});
}