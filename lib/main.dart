import 'package:e_commers/Bloc/Admin/AdminCategoryBloc/admin_category_bloc.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/Cart/cart_bloc.dart';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/Bloc/Personal/personal_bloc.dart';
import 'package:e_commers/Bloc/Product/product_bloc.dart';
import 'package:e_commers/Bloc/Upload/upload_bloc.dart';
import 'package:e_commers/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),
        BlocProvider(create: (context) => GeneralBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => PersonalBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => UploadBloc()),
        BlocProvider(create: (context) => AdminCategoryBloc()),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        builder: () => MaterialApp(
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'E-Commers Products',
          initialRoute: 'loadingPage',
          routes: routes,
        ),
      ),
    );
  }
}
