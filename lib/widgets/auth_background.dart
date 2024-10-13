import 'package:flutter/material.dart';
import 'package:marketplace/widgets/auth_background_c1.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        const AuthBackgorundC1(),
        SafeArea(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          child: const Icon(
            Icons.person_pin_circle_rounded,
            color: Colors.white,
            size: 100,
          ),
        )),
        child,
      ]),
    );
  }
}
