import 'package:e_commers/Bloc/Admin/AdminProductBloc/admin_product_bloc.dart';
import 'package:e_commers/Controller/HomeController.dart';
import 'package:e_commers/Helpers/ModalFrave.dart';
import 'package:e_commers/Helpers/ModalLoading.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Views/Profile/AdminProducts/AddAdminProduct.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class AdminProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(text: 'Manage Products', color: Colors.black),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        // height: 1.sh,
        child: Column(
          children: [
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'All Products',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).push(customRoute(
                          page: AddAdminProduct(), curved: Curves.easeInOut)),
                      child: Text(
                        "Add New Product",
                        style: TextStyle(fontSize: 15.sm),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: _ListProducts(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListProducts extends StatefulWidget {
  @override
  State<_ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<_ListProducts> {
  @override
  Widget build(BuildContext context) {
    final _adminCategoryBloc = BlocProvider.of<AdminProductBloc>(context);
    return BlocListener<AdminProductBloc, AdminProductState>(
      listener: (context, state) {
        if (state is DeleteProductLoadingState) {
          modalLoading(context, 'Deleting Product...');
        } else if (state is DeleteProductSuccessState) {
          setState(() {});
          Navigator.of(context).pop();
          modalFrave(context, 'Product Deleted Successfully');
        } else if (state is DeleteProductFailureState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: CustomText(text: 'Error Deleting Product'),
              backgroundColor: Colors.red));
        }
      },
      child: Container(
        height: 600.sm,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<Product>>(
          future: dbHomeController.getListProductsHome(),
          builder: (context, snapshot) {
            print("This is snapsohot of product data ${snapshot.data}");
            List<Product> list = snapshot.data;

            return !snapshot.hasData
                ? _LoadingShimmerProducts()
                : RefreshIndicator(
                    onRefresh: () async {
                      await dbHomeController.getListProductsHome();
                      setState(() {});
                      return dbHomeController.getListProductsHome();
                    },
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: list.length == null ? 0 : list.length,
                      itemBuilder: (context, i) => Container(
                        margin: EdgeInsets.all(10.sm),
                        padding: EdgeInsets.symmetric(vertical: 10.sm),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color(0xff0C6CF2).withOpacity(.1),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              list[i].nameProduct,
                              style: GoogleFonts.getFont('Roboto',
                                  fontSize: 18, color: Color(0xff0C6CF2)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Container(
                              width: 100.sm,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    splashColor:
                                        Color.fromARGB(255, 169, 199, 170),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(customRoute(
                                          page: AddAdminProduct(
                                              isUpdate: true, product: list[i]),
                                          curved: Curves.easeInOut));
                                    },
                                  ),
                                  IconButton(
                                    splashColor:
                                        Color.fromARGB(255, 253, 154, 154),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _adminCategoryBloc.add(
                                          DeleteProductEvent(id: list[i].id));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class _LoadingShimmerProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.sm,
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10.sm),
              height: 50.sm,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Color(0xFFF7F7F7),
                child: Container(
                  color: Colors.white,
                ),
              ),
            );
          }),
    );
  }
}
