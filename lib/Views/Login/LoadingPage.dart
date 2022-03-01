import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Helpers/Colors.dart';
import 'package:e_commers/Views/Start/HomeScreenPage.dart';
import 'package:e_commers/Views/Home/HomePage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogInState) {
          BlocProvider.of<AuthBloc>(context).add(GetPersistentRoleEvent());
          Navigator.of(context).pushReplacement(
              customRoute(page: HomePage(), curved: Curves.easeInOut));
        } else if (state is LogOutState) {
          Navigator.of(context).pushReplacement(
              customRoute(page: HomeScreenPage(), curved: Curves.easeInOut));
        }
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15.0),
            height: 120,
            width: 280,
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: 'Fashion Feet ',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 15.0),
                    CustomText(
                      text: 'Loading...',
                      fontSize: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
