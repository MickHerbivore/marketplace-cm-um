import 'package:flutter/material.dart';
import 'package:marketplace/models/product.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Product product;
  ProductFormProvider(this.product);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
