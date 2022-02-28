import 'dart:convert';
import 'package:e_commers/Helpers/BaseServerUrl.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Models/ResponseModels.dart';
import 'package:e_commers/Models/UploadPicture.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AdminController {
  String server = baseServerUrl;
  // baseServerUrl

  final secureStorage = FlutterSecureStorage();

  Future<ResponseModels> addCategory({String category, String picture}) async {
    final token = await readToken();
    final resp = await http.post(Uri.parse('$server/category'), headers: {
      'Accept': 'application/json',
      'xx-token': token
    }, body: {
      'category': category,
      'picture': picture,
    });

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> updateCategory(
      {String id, String category, String picture}) async {
    final token = await readToken();
    final resp = await http.put(Uri.parse('$server/category'), headers: {
      'Accept': 'application/json',
      'xx-token': token
    }, body: {
      "id": id,
      'category': category,
      'picture': picture,
    });

    print("I am here in upsate category $resp");

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> deleteCategory({String id}) async {
    final token = await readToken();
    final resp = await http.delete(Uri.parse('$server/category'),
        headers: {'Accept': 'application/json', 'xx-token': token},
        body: {"id": id});

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> getCategoryById({String id}) async {
    final token = await readToken();
    final resp = await http.get(
      Uri.parse('$server/category/$id'),
      headers: {'Accept': 'application/json', 'xx-token': token},
    );

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> addProduct({Product product}) async {
    final token = await readToken();
    final data = {
      "nameProduct": product.nameProduct,
      "description": product.description,
      "codeProduct": product.codeProduct,
      "stock": product.stock.toString(),
      "price": product.price.toString(),
      "status": product.status,
      "picture": product.picture,
      "category_id": product.categoryId.id.toString()
    };
    print("This is patload daa $data");

    final resp = await http.post(Uri.parse('$server/product'),
        headers: {'Accept': 'application/json', 'xx-token': token}, body: data);
    print("This is resp $resp");

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> updateProduct({Product product}) async {
    final token = await readToken();
    final data = {
      "id": product.id.toString(),
      "nameProduct": product.nameProduct,
      "description": product.description,
      "codeProduct": product.codeProduct,
      "stock": product.stock.toString(),
      "price": product.price.toString(),
      "status": product.status,
      "picture": product.picture,
      "category_id": product.categoryId.id.toString()
    };
    print("This is patload daa $data");

    final resp = await http.put(Uri.parse('$server/product'),
        headers: {'Accept': 'application/json', 'xx-token': token}, body: data);
    print("This is resp $resp");

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> deleteProduct({String id}) async {
    final token = await readToken();
    final resp = await http.delete(Uri.parse('$server/product'),
        headers: {'Accept': 'application/json', 'xx-token': token},
        body: {"id": id});

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> getProductById({String id}) async {
    final token = await readToken();
    final resp = await http.get(
      Uri.parse('$server/category/$id'),
      headers: {'Accept': 'application/json', 'xx-token': token},
    );

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<UploadPicture> uploadPicture({String picture}) async {
    final token = await readToken();

    var request =
        http.MultipartRequest('POST', Uri.parse('$server/upload-picture'))
          ..headers['Accept'] = 'application/json'
          ..headers['xx-token'] = token
          ..files.add(await http.MultipartFile.fromPath('picture', picture));

    final resp = await request.send();
    var datas = await http.Response.fromStream(resp);

    return UploadPicture.fromJson(jsonDecode(datas.body));
  }

  // Flutter Secure Storage

  Future<String> readToken() async {
    return secureStorage.read(key: 'xtoken');
  }
}

final adminController = AdminController();
