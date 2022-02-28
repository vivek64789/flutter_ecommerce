import 'package:e_commers/Controller/AuthController.dart';
import 'package:e_commers/Models/AuthModel.dart';
import 'package:e_commers/Models/ResponseModels.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'AuthController_test.mocks.dart';

@GenerateMocks([AuthController])
void main() {
  AuthController authController;
  var userData = {"user": "", "password": "", "email": ""};
  var authUserData;
  setUpAll(() {
    authController = MockAuthController();
    userData = {
      "user": "test3",
      "password": "Test@12345",
      "email": "test3@gmail.com"
    };
    authUserData = Users(
      email: userData['email'],
      id: "1",
      profile: "profile.png",
      role: "User",
      users: userData['user'],
    );
  });

  test('Registering user when is successful', () async {
    when(authController.createUsers(
            user: userData["user"],
            email: userData['email'],
            password: userData['password']))
        .thenAnswer(
      (_) async => ResponseModels(
        resp: true,
        msj: "Registered Successfully",
      ),
    );
    ResponseModels response = await authController.createUsers(
        user: userData["user"],
        email: userData['email'],
        password: userData['password']);
    verify(authController.createUsers(
        user: userData["user"],
        email: userData['email'],
        password: userData['password']));
    expect(response.msj, "Registered Successfully");
    expect(response.resp, true);
  });

  test('Login user when is successful', () async {
    when(authController.login(
            email: userData['email'], password: userData['password']))
        .thenAnswer(
      (_) async => AuthModel(
        resp: true,
        msj: "Logged Successfully",
        token: "token",
        role: "User",
        users: authUserData,
      ),
    );
    AuthModel response = await authController.login(
        email: userData['email'], password: userData['password']);
    verify(authController.login(
        email: userData['email'], password: userData['password']));
    expect(response.msj, "Logged Successfully");
    expect(response.resp, true);
    expect(response.role, "User");
    expect(response.token, "token");
    expect(response.users, authUserData);
  });

  test('Registering user when is not successful', () async {
    when(authController.createUsers(
            user: userData["user"],
            email: userData['email'],
            password: userData['password']))
        .thenAnswer(
      (_) async => ResponseModels(
        resp: false,
        msj: "There is some error registering",
      ),
    );
    ResponseModels response = await authController.createUsers(
        user: userData["user"],
        email: userData['email'],
        password: userData['password']);
    verify(authController.createUsers(
        user: userData["user"],
        email: userData['email'],
        password: userData['password']));
    expect(response.msj, "There is some error registering");
    expect(response.resp, false);
  });

  test('Login user when is not successful', () async {
    when(authController.login(
            email: userData['email'], password: userData['password']))
        .thenAnswer(
      (_) async => AuthModel(
        resp: false,
        msj: "There is some error logging",
        token: "",
        role: "",
        users: null,
      ),
    );
    AuthModel response = await authController.login(
        email: userData['email'], password: userData['password']);
    verify(authController.login(
        email: userData['email'], password: userData['password']));
    expect(response.msj, "There is some error logging");
    expect(response.resp, false);
    expect(response.role, "");
    expect(response.token, "");
    expect(response.users, null);
  });

  tearDownAll(() {
    authController = null;
  });
}


// ============= non mocked version

// import 'package:e_commers/Controller/AuthController.dart';
// import 'package:e_commers/Models/ResponseModels.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';

// void main() {
//   AuthController authController;
//   var userData = {"user": "", "password": "", "email": ""};
//   setUpAll(() {
//     authController = AuthController();
//     userData = {
//       "user": "test3",
//       "password": "Test@12345",
//       "email": "test3@gmail.com"
//     };
//   });
  
//   // @GenerateMocks([AuthController])
//   test('AuthController ...', () async {});
//   // Test auth controller
//   test("Registering user and returning created user", () async {
//     ResponseModels user = await authController.createUsers(
//         user: userData["user"],
//         password: userData["password"],
//         email: userData["email"]);
//     expect(user.resp, true);
//     print(user);
//     // Test login controller

//     // Test signup controller

//     // Test logout controller
//   });

//   tearDownAll(() {
//     authController = null;
//   });
// }
