import 'package:e_commers/Controller/HomeController.dart';
import 'package:e_commers/Models/Home/CategoriesProducts.dart';
import 'package:e_commers/Models/Home/HomeCarousel.dart';
import 'package:e_commers/Models/Product/Product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'HomeController_test.mocks.dart';

@GenerateMocks([HomeController])
void main() {
  HomeController homeController;
  List<SliderHome> listSliderHome;
  List<Category> listCategory;
  List<Product> listProduct;
  setUpAll(() {
    homeController = MockHomeController();
    listSliderHome = [
      SliderHome(
        category: "Apple",
        id: "1",
        image: "image.png",
        v: 1,
      ),
      SliderHome(
        category: "Ball",
        id: "2",
        image: "image.png",
        v: 2,
      ),
      SliderHome(
        category: "Cat",
        id: "3",
        image: "image.png",
        v: 3,
      ),
    ];
    listCategory = [
      Category(
        id: "1",
        category: "Apple",
        picture: "image.png",
        status: true,
        v: 1,
      ),
      Category(
        id: "2",
        category: "Ball",
        picture: "image.png",
        status: false,
        v: 2,
      ),
      Category(
        id: "3",
        category: "Cat",
        picture: "image.png",
        status: true,
        v: 3,
      ),
    ];
    listProduct = [
      Product(
        id: "1",
        categoryId: "1",
        codeProduct: "1",
        description: "Description",
        nameProduct: "Apple Iphone 10",
        picture: "image.png",
        price: 100.0,
        status: "Active",
        stock: 100,
        v: 1,
      ),
      Product(
        id: "2",
        categoryId: "2",
        codeProduct: "2",
        description: "Description",
        nameProduct: "Apple Iphone 11",
        picture: "image.png",
        price: 100.0,
        status: "Active",
        stock: 100,
        v: 2,
      ),
    ];
  });
  test('Getting sliders for home ...', () async {
    when(homeController.getHomeCarouselSlider())
        .thenAnswer((realInvocation) async => listSliderHome);

    List<SliderHome> result = await homeController.getHomeCarouselSlider();
    expect(result, listSliderHome);
  });
  test('Getting sliders for home unsuccessful ...', () async {
    when(homeController.getHomeCarouselSlider())
        .thenAnswer((realInvocation) async => []);

    List<SliderHome> result = await homeController.getHomeCarouselSlider();
    expect(result, []);
  });
  test('Fetching list of categories that belongs to the products ...',
      () async {
    when(homeController.getListCategoriesProducts())
        .thenAnswer((realInvocation) async => listCategory);

    List<Category> result = await homeController.getListCategoriesProducts();
    expect(result, listCategory);
  });
  test(
      'Fetching list of categories that belongs to the products but returns empty ...',
      () async {
    when(homeController.getListCategoriesProducts())
        .thenAnswer((realInvocation) async => []);

    List<Category> result = await homeController.getListCategoriesProducts();
    expect(result, []);
  });
}
