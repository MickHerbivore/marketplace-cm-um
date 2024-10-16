import 'package:flutter/material.dart';
import 'package:marketplace/theme/my_theme.dart';

class AuthBackgorundC1 extends StatelessWidget {
  const AuthBackgorundC1({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen =
        MediaQuery.of(context).size; //obtiene el tamaño de la pantalla
    return Container(
      width: double.infinity,
      height: sizeScreen.height * 0.4, //40% de la pantalla
      decoration: customDecoration(),
      child: const Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child: Buble(),
          ),
          Positioned(
            top: -40,
            left: -30,
            child: Buble(),
          ),
          Positioned(
            top: -50,
            right: -20,
            child: Buble(),
          ),
          Positioned(
            bottom: -50,
            left: -20,
            child: Buble(),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: Buble(),
          ),
          Positioned(
            bottom: 20,
            right: 80,
            child: Buble(),
          ),
        ],
      ),
    );
  }

  BoxDecoration customDecoration() => BoxDecoration(
          gradient: LinearGradient(colors: [
        MyTheme.secondary,
        MyTheme.secondary.withOpacity(0.5),
      ]));
}

class Buble extends StatelessWidget {
  const Buble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.15)),
    );
  }
}
