import 'package:e_commers/Helpers/Colors.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:e_commers/Widgets/CustomButton.dart';
import 'package:flutter/material.dart';

class HomeScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Welcome to',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Fashion',
                            fontSize: 32,
                            color: Colors.white,
                          ),
                          CustomText(
                              text: ' Feet',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ],
                      ),
                      CustomText(
                        text: 'Find All Products Quickly',
                        fontSize: 20,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      CustomButton(
                          text: 'Sign Up',
                          color: Color(0xff1C2834),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('signUpPage')),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Already have an account?', fontSize: 17),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      CustomButton(
                        text: 'Sign In',
                        color: Color(0xFFE9EFF9),
                        textColor: Colors.black,
                        onPressed: () =>
                            Navigator.of(context).pushNamed('signInPage'),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
