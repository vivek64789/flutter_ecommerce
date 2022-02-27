import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/Personal/personal_bloc.dart';
import 'package:e_commers/Helpers/ModalFrave.dart';
import 'package:e_commers/Helpers/ModalLoading.dart';
import 'package:e_commers/Widgets/CircleFrave.dart';
import 'package:e_commers/Widgets/TextFormFrave.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:e_commers/Widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddAdminCategory extends StatefulWidget {
  @override
  _AddAdminCategoryState createState() => _AddAdminCategoryState();
}

class _AddAdminCategoryState extends State<AddAdminCategory> {
  TextEditingController categoryController;
  TextEditingController pictureController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthBloc>(context);
    final personalBloc = BlocProvider.of<PersonalBloc>(context);

    return BlocListener<PersonalBloc, PersonalState>(
      listener: (context, state) {
        if (state is LoadingPersonalState) {
          modalLoading(context, 'Adding user...');
        } else if (state is SuccessRegisterPersona) {
          Navigator.of(context).pop();
          modalFrave(context, 'User Added');
        } else if (state is FailureRegisterState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: CustomText(text: 'Error adding user'),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: CustomText(text: 'Add Category', color: Colors.black),
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
              CustomText(text: 'Category Information', fontSize: 18),
              SizedBox(height: 10.0),
              TextFormFrave(
                controller: categoryController,
                hintText: 'Enter Category',
                prefixIcon: Icons.category,
                fontSize: 18,
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: TextButton(
                        onPressed: () => changePicture(context),
                        child: CustomText(
                          text: 'Choose Category Picture',
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      )),
                  SizedBox(height: 15.0),
                ],
              ),
              SizedBox(height: 15.0),
              CustomButton(
                text: 'Save',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                height: 55,
                onPressed: () {
                  // if (_keyForm.currentState.validate()) {
                  //   personalBloc.add(RegisterPersonalInformationEvent(
                  //       name: firstnameController.text,
                  //       lastName: lastnameController.text,
                  //       phone: phoneController.text,
                  //       address: addressController.text,
                  //       reference: referenceController.text));
                  // }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  File image;
  String img;
  final picker = ImagePicker();

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;

      BlocProvider.of<AuthBloc>(context).add(ChangePictureProfile(image: img));
    }

    setState(() {});
  }

  Future getTakeFoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;
      BlocProvider.of<AuthBloc>(context).add(ChangePictureProfile(image: img));
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
