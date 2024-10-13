import 'package:flutter/material.dart';
import 'package:marketplace/theme/my_theme.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
          decoration: _createDecoration(),
          width: double.infinity,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: url == null
                  ? const Image(
                      image: AssetImage('assets/no-image.png'),
                      fit: BoxFit.fitWidth,
                    )
                  : FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(url!),
                      fit: BoxFit.cover,
                    ),
            ),
          )),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: MyTheme.primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
