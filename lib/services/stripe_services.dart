import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe/constants.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices instance =
      StripeServices._(); // so that instance can only be ccreted only one time

  //making the payment
  Future<void> makePayment() async {
    try {
      //payment intent creation with our peivate key, and getting the client intent key
      String? paymentIntentClientSecret = await _createPaymentIntent(10, 'usd');

      //use the cleint intent key for  showing the payement sheet
      if (paymentIntentClientSecret == null) {
        return;
      } else {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Faheem Abbas',
        ));
      }
      //processing the actual payement
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  //making the intent
  //payment intent examples are available on the stripe documentation
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency
      };

      var respone = await dio.post(
          "https://api.stripe.com/v1/payment_intents", //from the create intent documentation
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          }));

      if (respone.data != null) {
        // print(respone.data);
        return respone.data[
            "client_secret"]; // we only need this for the further processing
      }

      return null;
    } catch (e) {
      print(e);

      return null;
    }
  }

  //after the payment sheet is displayed now we need to process the payement
  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  // the payement intent always accept the amount in the cents so writting a function for converting buks($) to cents
  String _calculateAmount(int amount) {
    final finalAmount = amount * 100;
    return finalAmount.toString();
  }
}
