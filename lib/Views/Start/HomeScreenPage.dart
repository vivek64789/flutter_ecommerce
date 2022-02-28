import 'package:e_commers/Widgets/CustomText.dart';
import 'package:e_commers/Widgets/CustomButton.dart';
import 'package:flutter/material.dart';

class HomeScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E4DD8),
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
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/logo-white.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'FRAVE', fontSize: 32, color: Colors.white),
                          CustomText(
                              text: ' SHOP',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ],
                      ),
                      CustomText(
                        text: 'All your products in your hands',
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
                          text: 'Sign Up with Email ID',
                          color: Color(0xff1C2834),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('signUpPage')),
                      SizedBox(height: 15.0),
                      CustomButton(
                        text: 'Sign Up with Google',
                        color: Color(0xFFE9EFF9),
                        textColor: Colors.black,
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Already have an account?', fontSize: 17),
                          TextButton(
                            child: CustomText(
                                text: 'Sign In',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('signInPage'),
                          ),
                        ],
                      ),
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
