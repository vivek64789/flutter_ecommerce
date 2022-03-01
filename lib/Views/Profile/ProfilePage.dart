import 'dart:async';
import 'dart:io';
import 'package:e_commers/Helpers/BaseServerUrl.dart';
import 'package:e_commers/Helpers/Colors.dart';
import 'package:e_commers/Helpers/LoadingUpload.dart';
import 'package:e_commers/Views/Favorite/FavoritePage.dart';
import 'package:e_commers/Views/Profile/AdminCategories/AdminCategories.dart';
import 'package:e_commers/Views/Profile/AdminProducts/AdminProducts.dart';
import 'package:e_commers/Views/Profile/Card/CreditCardPage.dart';
import 'package:e_commers/Views/Profile/Shopping/ShoppingPage.dart';
import 'package:e_commers/Views/Start/HomeScreenPage.dart';
import 'package:e_commers/Widgets/CircleFrave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animate_do/animate_do.dart';

import 'package:e_commers/Views/Profile/InformationPage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Widgets/BottomNavigationFrave.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:proximity_sensor/proximity_sensor.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Stack(
        children: [
          ListProfile(),
          Positioned(
            bottom: 20,
            child: Container(
                width: size.width,
                child: Align(child: BottomNavigationFrave(index: 4))),
          ),
        ],
      ),
    );
  }
}

class ListProfile extends StatefulWidget {
  @override
  _ListProfileState createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  File image;
  String img;
  final picker = ImagePicker();
  bool _isNear = false;
  StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    listenProximitySensor();
    super.initState();
  }

  // dispose
  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<void> listenProximitySensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });
    });
  }

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

  @override
  Widget build(BuildContext context) {
    _isNear ? getTakeFoto() : print("no");
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingImageState) {
          loadinUploadFile(context);
        } else if (state is ChangeProfileSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: CustomText(text: 'Image Updated success', fontSize: 18),
              backgroundColor: Colors.green));
        } else if (state is LogOutState) {
          Navigator.pushReplacement(context,
              customRoute(page: HomeScreenPage(), curved: Curves.easeInOut));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 35.0, bottom: 90.0),
            children: [
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: state.profile == ''
                          ? GestureDetector(
                              onTap: () => changeProfile(context),
                              child: CircleFrave(
                                color: primaryColor,
                                radius: 90,
                                child: Center(
                                    child: CustomText(
                                        text: state.username
                                            .substring(0, 2)
                                            .toUpperCase(),
                                        fontSize: 45,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ))
                          : GestureDetector(
                              onTap: () => changeProfile(context),
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(publicServerUrl +
                                            state.profile.toString()))),
                              ),
                            )),
                  SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BounceInRight(
                        child: Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              text: state.username,
                              fontSize: 21,
                              color: Colors.black,
                            )),
                      ),
                      FadeInRight(
                        child: Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              text: state.email,
                              fontSize: 18,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Container(
                height: 122,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Column(
                  children: [
                    CardProfile(
                      text: 'Personal Information',
                      borderRadius: BorderRadius.circular(50.0),
                      icon: Icons.person_outline_rounded,
                      backgroundColor: Color(0xff7882ff),
                      onPressed: () => Navigator.of(context).push(customRoute(
                          page: InformationPage(), curved: Curves.easeInOut)),
                    ),
                    _Divider(size: size),
                    CardProfile(
                      text: 'Credit Card',
                      borderRadius: BorderRadius.circular(50.0),
                      icon: Icons.credit_card_rounded,
                      backgroundColor: Color(0xffFFCD3A),
                      onPressed: () => Navigator.of(context).push(customRoute(
                          page: CreditCardPage(), curved: Curves.easeInOut)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              state.role == "Admin"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: CustomText(
                            text: 'Admin Panel',
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 110.h,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Column(
                            children: [
                              CardProfile(
                                text: 'Categories',
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30.0)),
                                backgroundColor: Color(0xff2EAA9B),
                                icon: Icons.settings_applications,
                                onPressed: () => Navigator.of(context).push(
                                    customRoute(
                                        page: AdminCategories(),
                                        curved: Curves.fastLinearToSlowEaseIn)),
                              ),
                              _Divider(size: size),
                              CardProfile(
                                text: 'Products',
                                backgroundColor: Color(0xff0716A5),
                                icon: Icons.shopping_bag_outlined,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30.0)),
                                onPressed: () => Navigator.of(context).push(
                                    customRoute(
                                        page: AdminProducts(),
                                        curved: Curves.easeInOut)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: CustomText(
                  text: 'General',
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 130.sm,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Column(
                  children: [
                    CardProfile(
                      text: 'Favorites',
                      backgroundColor: Color(0xfff28072),
                      icon: Icons.favorite_border_rounded,
                      borderRadius: BorderRadius.zero,
                      onPressed: () => Navigator.of(context).push(customRoute(
                          page: FavoritePage(), curved: Curves.easeInOut)),
                    ),
                    _Divider(size: size),
                    CardProfile(
                      text: 'Fashion Feet ping',
                      backgroundColor: Color(0xff0716A5),
                      icon: Icons.shopping_bag_outlined,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30.0)),
                      onPressed: () => Navigator.of(context).push(customRoute(
                          page: ShoppingPage(), curved: Curves.easeInOut)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              CardProfile(
                text: 'Sign Out',
                borderRadius: BorderRadius.circular(50.0),
                icon: Icons.power_settings_new_sharp,
                backgroundColor: Colors.red,
                onPressed: () => authBloc.add(LogOutEvent()),
              ),
            ],
          );
        },
      ),
    );
  }

  void changeProfile(BuildContext context) {
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

class _Divider extends StatelessWidget {
  final Size size;

  _Divider({
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 65.0, right: 25.0),
      child: Container(
        height: 1,
        width: size.width,
        color: Colors.grey[300],
      ),
    );
  }
}

class CardProfile extends StatelessWidget {
  final String text;
  final Function onPressed;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final IconData icon;

  CardProfile(
      {this.text,
      this.onPressed,
      this.borderRadius,
      this.backgroundColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: borderRadius),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: 0.0,
        margin: EdgeInsets.all(0.0),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    CustomText(
                      text: text,
                      fontSize: 18,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
