import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:e_commers/Bloc/Admin/AdminProductBloc/admin_product_bloc.dart';
import 'package:e_commers/Bloc/Upload/upload_bloc.dart';
import 'package:e_commers/Controller/HomeController.dart';
import 'package:e_commers/Helpers/LoadingUpload.dart';
import 'package:e_commers/Helpers/ModalFrave.dart';
import 'package:e_commers/Helpers/ModalLoading.dart';
import 'package:e_commers/Models/Home/CategoriesProducts.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:e_commers/Widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddAdminProduct extends StatefulWidget {
  String category;
  String id;
  bool isUpdate = false;
  AddAdminProduct({this.category, this.id, this.isUpdate});

  @override
  _AddAdminProductState createState() => _AddAdminProductState();
}

class _AddAdminProductState extends State<AddAdminProduct> {
  TextEditingController categoryController = TextEditingController();
  var category = "";
  var id = "";
  bool isUpdate = false;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    category = widget.category;
    id = widget.id;
    isUpdate = widget.isUpdate == null ? false : widget.isUpdate;
    super.initState();
  }

  @override
  void dispose() {
    // BlocProvider.of<UploadBloc>(context).add(ResetUpload());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProductBloc = BlocProvider.of<AdminProductBloc>(context);
    final uploadBloc = BlocProvider.of<UploadBloc>(context).state;

    return BlocListener<AdminProductBloc, AdminProductState>(
      listener: (context, state) {
        if (state is LoadingAddProductState) {
          modalLoading(context, 'Adding product...');
        } else if (state is AddProductSuccessState) {
          Navigator.of(context).pop();
          modalFrave(context, 'Product Added Successfully');
        } else if (state is FailureAddProductState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: CustomText(text: 'Error adding Product'),
              backgroundColor: Colors.red));
        } else if (state is LoadingUpdateProductState) {
          modalLoading(context, 'Updating Product...');
        } else if (state is UpdateProductSuccessState) {
          Navigator.of(context).pop();
          modalFrave(context, 'Product Updated Successfully');
        } else if (state is FailureUpdateProductState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: CustomText(text: 'Error Updating category'),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: CustomText(
                text: isUpdate ? "Update $category" : 'Add Product',
                color: Colors.black),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: Form(
          key: _keyForm,
          child: ListView(
            physics: BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            children: [
              SizedBox(height: 30.0),
              CustomText(text: 'Product Information', fontSize: 18),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Product Name"),
                initialValue: category,
                onChanged: (value) => category = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter product';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    InputDecoration(hintText: "Enter Product Description"),
                initialValue: category,
                onChanged: (value) => category = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Product Code"),
                initialValue: category,
                keyboardType: TextInputType.number,
                onChanged: (value) => category = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    InputDecoration(hintText: "Enter Total Stock Quantity"),
                keyboardType: TextInputType.number,
                initialValue: category,
                onChanged: (value) => category = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Price"),
                keyboardType: TextInputType.number,
                initialValue: category,
                onChanged: (value) => category = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              DropdownSearch<Category>(
                mode: Mode.BOTTOM_SHEET,
                items: getCategoriesList(),
                
                // onFind: (String filter) => getData(filter),
                itemAsString: (Category p) => p.category.toString(),
                onChanged: (Category data) => print(data),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Product Name"),
                initialValue: category,
                onChanged: (value) => category = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: BlocListener<UploadBloc, UploadState>(
                        listener: (context, state) {
                          if (state is LoadingImageState) {
                            loadinUploadFile(context);
                          } else if (state is UploadSuccess) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: CustomText(
                                    text: 'Image Uploaded success',
                                    fontSize: 18),
                                backgroundColor: Colors.green));
                            setState(() {});
                          }
                        },
                        child: TextButton(
                          onPressed: () => changePicture(context),
                          child: CustomText(
                            text: 'Choose Category Picture',
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                      )),
                  SizedBox(height: 15.0),
                ],
              ),
              SizedBox(height: 15.0),
              CustomButton(
                text: isUpdate ? "Update" : 'Save',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                height: 55,
                onPressed: () {
                  print("This is uploaded image ${uploadBloc.picture}");
                  if (_keyForm.currentState.validate()) {
                    !isUpdate
                        ? adminProductBloc.add(AddProductEvent(
                            product: category,
                            picture: uploadBloc.picture,
                          ))
                        : adminProductBloc.add(
                            UpdateProductEvent(
                              id: id,
                              product: category,
                              picture: uploadBloc.picture,
                            ),
                          );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Category> getCategoriesList() {
    List<Category> categoryList;
    dbHomeController.getListCategories().then((value) => categoryList = value);
    print(categoryList);
    return categoryList;
  }

  File image;
  String img;
  final picker = ImagePicker();

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;

      BlocProvider.of<UploadBloc>(context)
          .add(UploadPictureEvent(picture: img));

      print("This is uploaded picture");
    }

    setState(() {});
  }

  Future getTakeFoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;
      BlocProvider.of<UploadBloc>(context)
          .add(UploadPictureEvent(picture: img));
    }
    setState(() {});
  }

  void changePicture(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      enableDrag: false,
      builder: (context) {
        return Container(
            height: 190,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 25.0),
                  child: CustomText(
                      text: 'Change profile picture',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15.0),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    child: InkWell(
                      onTap: () {
                        getImage();
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 22.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: 'Select an image', fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    child: InkWell(
                      onTap: () {
                        getTakeFoto();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 22.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text: 'Take a picture',
                              fontSize: 18,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
