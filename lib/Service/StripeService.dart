import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  StripeService._privateConstructor();
  static final _intance = StripeService._privateConstructor();
  factory StripeService() => _intance;
  String _paymentApiUrl = "https://api.stripe.com/v1/payment_intents";

  String _secretKey =
      "sk_test_51Ih5GzHmsIXlXA5BXcXB2pu9zIPUO4m3AI1aJ7alTbGsvE4tquIosr7ujx079Bo88JtGKz7JkeEJLBsOZFeJnBm000HB1PVyYk";

  String publishableKey =
      "pk_test_51Ih5GzHmsIXlXA5B2yqi16ahSis9qPIV9w1dX3M9nsdesNiEIaj7EgqByz8eN0TJlyRZrD8kDKaKdyifNybdZtue00w4N0rVya";

  Map<String, dynamic> _paymentIntentData;

  Future<bool> makePayment(double amount) async {
    try {
      _paymentIntentData = await createPaymentIntent(amount, "USD");
      print(_paymentIntentData);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: _paymentIntentData["client_secret"],
        applePay: true,
        testEnv: true,
        currencyCode: "USD",
        merchantCountryCode: "US",
        // style: ThemeMode.system,
        merchantDisplayName: "My Shop",
      ));
      var result = await displayPaymentSheet();
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      // await Stripe.instance.presentPaymentSheet();

      await Stripe.instance.presentPaymentSheet().then((newValue) {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("paid successfully")));

        _paymentIntentData = null;
      });
      return true;
    } on StripeException catch (e) {
      print(e);
      return false;
    }
  }

  createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card"
      };

      var response = await http.post(Uri.parse(_paymentApiUrl),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer $_secretKey"
          },
          body: body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  String calculateAmount(double amount) {
    final price = amount.toInt();
    return price.toString();
  }
}

//   void init() {
//     StripePayment.setOptions(StripeOptions(
//         publishableKey: _apiKey, androidPayMode: 'test', merchantId: 'test'));
//   }

//   Future<StripeResponseCustom> payWithCardExists(
//       {@required String amount,
//       @required String currency,
//       @required CreditCard creditCard}) async {
//     try {
//       final paymentMethod = await StripePayment.createPaymentMethod(
//           PaymentMethodRequest(card: creditCard));

//       return await _makePayment(
//           amount: amount, currency: currency, paymentMethod: paymentMethod);
//     } catch (e) {
//       return StripeResponseCustom(ok: false, msg: e.toString());
//     }
//   }

//   Future<StripeResponseCustom> payWithNewCard(
//       {@required String amount, @required String currency}) async {
//     try {
//       final paymentMethod = await StripePayment.paymentRequestWithCardForm(
//           CardFormPaymentRequest());

//       return await _makePayment(
//           amount: amount, currency: currency, paymentMethod: paymentMethod);
//     } catch (e) {
//       return StripeResponseCustom(ok: false, msg: e.toString());
//     }
//   }

//   Future<PaymentIntentResponse> _paymentIntent(
//       {@required String amount, @required String currency}) async {
//     try {
//       final resp = await http.post(Uri.parse(_paymentApiUrl), headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $_secretKey'
//       }, body: {
//         'amount': amount,
//         'currency': currency
//       });

//       return PaymentIntentResponse.fromJson(jsonDecode(resp.body));
//     } catch (e) {
//       return PaymentIntentResponse(status: '400');
//     }
//   }

//   Future<StripeResponseCustom> _makePayment(
//       {@required String amount,
//       @required String currency,
//       @required PaymentMethod paymentMethod}) async {
//     try {
//       final paymentIntent =
//           await _paymentIntent(amount: amount, currency: currency);

//       final paymentResult = await StripePayment.confirmPaymentIntent(
//           PaymentIntent(
//               clientSecret: paymentIntent.clientSecret,
//               paymentMethodId: paymentMethod.id));

//       if (paymentResult.status == 'succeeded') {
//         return StripeResponseCustom(ok: true);
//       } else {
//         return StripeResponseCustom(ok: false, msg: 'Something went wrong');
//       }
//     } catch (e) {
//       return StripeResponseCustom(ok: false, msg: e.toString());
//     }
//   }
// }

final stripeService = StripeService();
