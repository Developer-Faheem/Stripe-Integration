import 'package:flutter/material.dart';
import 'package:stripe/services/stripe_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 197, 170, 244),
        title: const Text("Stripe Payment Integration"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
              onPressed: () {
                StripeServices.instance.makePayment();
              },
              color: const Color.fromARGB(255, 197, 170, 244),
              child: const Text("Pay Now"),
            ),
          )
        ],
      ),
    );
  }
}
