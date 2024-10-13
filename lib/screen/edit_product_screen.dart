import 'package:flutter/material.dart';
import 'package:marketplace/models/category.dart';
import 'package:marketplace/providers/product_form.dart';
import 'package:marketplace/services/category_service.dart';
import 'package:marketplace/services/product_service.dart';
import 'package:marketplace/ui/input_decortions.dart';
import 'package:marketplace/widgets/product_image.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductFormProvider(productService.selectedProduct!),
        ),
        ChangeNotifierProvider(
            create: (context) => CategoryService(), // Añade el CategoryService al provider
        ),
      ],
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final ProductService productService;

  const _ProductScreenBody({
    super.key,
    required this.productService
    });
  
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct!.productImage),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back, size: 40, color: Colors.black),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      
                    },
                    icon: const Icon(Icons.add_shopping_cart, size: 40, color: Colors.black),
                  ),
                ),
              ],
            ),
            _ProductForm(),
          ]
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if (!productForm.isValidForm()) return;

              await productService.deleteProduct(productForm.product, context);
              Navigator.pushNamed(context, 'list');
            },
            heroTag: 'delete',
            child: const Icon(Icons.delete_forever),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'edit',
            child: const Icon(Icons.data_saver_on_sharp), 
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              
              await productService.editOrCreateProduct(productForm.product);
              Navigator.pushNamed(context, 'list');
            },
          ),
        ]
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    final categoryService = Provider.of<CategoryService>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.productImage,
                onChanged: (value) => product.productImage = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'la url es obligatoria';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'url',
                  labelText: 'imagen',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'el nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: '-----',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 20),
              categoryService.isLoading 
                ? const CircularProgressIndicator()
                : DropdownButtonFormField<Categoria>(
                    value: (product.categoryId != ''
                      ? categoryService.categories.firstWhere((category) => category.id == product.categoryId)
                      : null
                    ),
                    items: categoryService.categories.map((category) {
                      return DropdownMenuItem<Categoria>(
                        value: category,
                        child: Text(category.categoryName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      categoryService.selectedCategory = value;
                      product.categoryId = value!.id;
                    },
                    decoration: InputDecortions.authInputDecoration(
                      labelText: 'Categoría',
                      hinText: 'Seleccionar categoría',
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
