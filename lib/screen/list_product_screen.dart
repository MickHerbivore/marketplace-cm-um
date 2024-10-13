import 'package:flutter/material.dart';
import 'package:marketplace/models/category.dart';
import 'package:marketplace/models/product.dart';
import 'package:marketplace/screen/loading_screen.dart';
import 'package:marketplace/services/category_service.dart';
import 'package:marketplace/services/product_service.dart';
import 'package:marketplace/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});
  @override
  ListProductScreenState createState() => ListProductScreenState();
}

class ListProductScreenState extends State<ListProductScreen> {
  String searchText = '';
  Categoria? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final categoryService = Provider.of<CategoryService>(context);

    if (productService.isLoading) return const LoadingScreen();

    final filteredProducts = productService.products.where((product) {
      final matchesName = product.productName.toLowerCase().contains(searchText.toLowerCase());
      final matchesCategory = selectedCategory == null || product.categoryId == selectedCategory!.id || selectedCategory!.id == "";
      return matchesName && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar producto...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: DropdownButton<Categoria>(
                    hint: const Text('Seleccionar categoría'),
                    value: selectedCategory,
                    isExpanded: true,
                    items: categoryService.categories.map((category) {
                      return DropdownMenuItem<Categoria>(
                        value: category,
                        child: Text(category.categoryName),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      ),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            productService.selectedProduct = filteredProducts[index].copy();
            Navigator.pushNamed(context, 'edit');
          },
          child: ProductCard(product: filteredProducts[index])
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.selectedProduct = Product(
            id: '',
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage: 'https://as2.ftcdn.net/v2/jpg/02/51/95/53/1000_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg',
            productState: '',
            categoryId: '',
          );
          Navigator.pushNamed(context, 'edit');
        },
      )
    );
  }

}