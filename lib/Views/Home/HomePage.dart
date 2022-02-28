import 'package:animate_do/animate_do.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/Bloc/Product/product_bloc.dart';
import 'package:e_commers/Controller/HomeController.dart';
import 'package:e_commers/Helpers/BaseServerUrl.dart';
import 'package:e_commers/Models/Home/CategoriesProducts.dart';
import 'package:e_commers/Models/Home/HomeCarousel.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Views/Cart/CartPage.dart';
import 'package:e_commers/Views/Products/DetailsProductPage.dart';
import 'package:e_commers/Views/Categories/CategoriesPage.dart';
import 'package:e_commers/Views/Start/HomeScreenPage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/BottomNavigationFrave.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake/shake.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShakeDetector detector;

  @override
  void initState() {
    // Shake
    print("Before shake");
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        print("Shake");
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Log Out"),
                content: Text("Are you sure, want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
                    },
                    child: Text("LOG OUT"),
                  ),
                ],
              );
            });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: Stack(
        children: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogOutState) {
                Navigator.pushReplacement(
                    context,
                    customRoute(
                        page: HomeScreenPage(), curved: Curves.easeInOut));
              }
            },
            child: ListHome(),
          ),
          Positioned(
            bottom: 20,
            child: Container(
                width: size.width,
                child: Align(
                    child: BlocBuilder<GeneralBloc, GeneralState>(
                        builder: (context, state) => BottomNavigationFrave(
                            index: 0, showMenu: state.showMenuHome)))),
          ),
        ],
      ),
    );
  }
}

class ListHome extends StatefulWidget {
  @override
  _ListHomeState createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  ScrollController scrollControllerHome = ScrollController();
  double scrollPrevious = 0;

  @override
  void initState() {
    scrollControllerHome.addListener(() {
      if (scrollControllerHome.offset > scrollPrevious) {
        BlocProvider.of<GeneralBloc>(context, listen: false)
            .add(OnShowHideMenuHome(showMenu: false));
      } else {
        BlocProvider.of<GeneralBloc>(context, listen: false)
            .add(OnShowHideMenuHome(showMenu: true));
      }

      scrollPrevious = scrollControllerHome.offset;
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollControllerHome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBlocState = BlocProvider.of<AuthBloc>(context).state;

    return SafeArea(
      child: Container(
        child: ListView(
          controller: scrollControllerHome,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeInLeft(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xff006CF2),
                            child: CustomText(
                              text: authBlocState.username
                                  .substring(0, 2)
                                  .toUpperCase(),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          CustomText(
                            text: authBlocState.username,
                            fontSize: 18,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () => Navigator.of(context).pushReplacement(
                          customRoute(
                              page: CartPage(), curved: Curves.easeInOut)),
                      child: Stack(
                        children: [
                          FadeInRight(
                              child: Container(
                                  height: 32,
                                  width: 32,
                                  child: SvgPicture.asset(
                                      'Assets/bolso-negro.svg',
                                      height: 25))),
                          Positioned(
                            left: 0,
                            top: 12,
                            child: FadeInDown(
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Color(0xff0C6CF2),
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: BlocBuilder<ProductBloc,
                                            ProductState>(
                                        builder: (context, state) => state
                                                    .amount ==
                                                0
                                            ? CustomText(
                                                text: '0',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)
                                            : CustomText(
                                                text:
                                                    '${state.products.length}',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 5.0, right: 10.0),
              child: _CarCarousel(),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Categories',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(customRoute(
                        page: CategoriesPage(), curved: Curves.easeInOut)),
                    child: Row(
                      children: [
                        CustomText(text: 'See All', fontSize: 17),
                        SizedBox(width: 5.0),
                        Icon(Icons.arrow_forward_ios_rounded,
                            size: 18, color: Color(0xff006CF2))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: _ListCategories(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Popular Products',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5.0),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(customRoute(
                            page: CategoriesPage(), curved: Curves.easeInOut)),
                        child: Row(
                          children: [
                            CustomText(text: 'See All', fontSize: 17),
                            SizedBox(width: 5.0),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 18, color: Color(0xff006CF2))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: _ListProducts(),
            )
          ],
        ),
      ),
    );
  }
}

class _ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: dbHomeController.getListProductsHome(),
      builder: (context, snapshot) {
        List<Product> list = snapshot.data;
        print("$list, this is snapshot of data");
        return !snapshot.hasData
            ? _LoadingShimmerProducts()
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 220),
                itemCount: list.length == null ? 0 : list.length,
                itemBuilder: (context, i) => Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DetailsProductPage(product: list[i]))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Hero(
                              tag: list[i].id,
                              child: Image.network(
                                publicServerUrl + list[i].picture,
                                height: 150,
                              )),
                        ),
                        Text(
                          list[i].nameProduct,
                          style: GoogleFonts.getFont('Roboto',
                              fontSize: 17, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        CustomText(text: '\$ ${list[i].price}', fontSize: 16),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Category>>(
        future: dbHomeController.getListCategoriesProducts(),
        builder: (context, snapshot) {
          List<Category> list = snapshot.data;

          return !snapshot.hasData
              ? _LoadingShimmerCategories()
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length == null ? 0 : list.length,
                  itemBuilder: (context, i) => Container(
                    margin: EdgeInsets.only(right: 8.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 150,
                    decoration: BoxDecoration(
                        color: Color(0xff0C6CF2).withOpacity(.1),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                      child: Text(
                        list[i].category,
                        style: GoogleFonts.getFont('Roboto',
                            fontSize: 18, color: Color(0xff0C6CF2)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class _CarCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<SliderHome>>(
          future: dbHomeController.getHomeCarouselSlider(),
          builder: (context, snapshot) {
            List<SliderHome> silerHome = snapshot.data;

            return !snapshot.hasData
                ? _LoadingShimmerCarosusel()
                : PageView.builder(
                    itemCount: silerHome.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    publicServerUrl + silerHome[i].image))),
                      );
                    },
                  );
          }),
    );
  }
}

class _LoadingShimmerProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Color.fromARGB(255, 248, 245, 245),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 250,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            Container(
              height: 250,
              width: 190,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ],
        ));
  }
}

class _LoadingShimmerCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Color(0xFFF7F7F7),
      child: Container(
        color: Colors.white,
      ),
    );
  }
}

class _LoadingShimmerCarosusel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Color(0xFFF7F7F7),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
