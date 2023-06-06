import 'package:app_with_animations/model/product_model.dart';
import 'package:app_with_animations/utils/get_cart.dart';
import 'package:app_with_animations/widgets/circle_icon.dart';
import 'package:app_with_animations/widgets/fade_in_image.dart';
import 'package:app_with_animations/widgets/icon_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product?> products = [];
  int sumOfPrice = 0;
  final String cacheKey = 'checkOutId';

  @override
  void initState() {
    super.initState();
    _loadCheckOutItems();
    _getPrice();
  }

  void _loadCheckOutItems() async {
    products = await getCheckOuts();
    _getPrice();
    setState(() {});
  }

  void _getPrice() {
    sumOfPrice = products.fold(0, (sum, e) => sum + (e?.price ?? 0));
    setState(() {});
  }

  Future<void> deleteCheckout(String productId) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> checkOut = prefs.containsKey(cacheKey)
        ? prefs.getStringList(cacheKey) as List<String>
        : <String>[];

    checkOut.remove(productId);

    prefs.setStringList(cacheKey, checkOut);
    products = await getCheckOuts();
    _getPrice();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            leading: CircleIcon(
              icon: Icons.arrow_back,
              iconColor: Colors.black,
              callBack: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (products.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 1,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(products[index]!.id.toString()),
                          onDismissed: (direction) {
                            deleteCheckout(products[index]!.id.toString());
                          },
                          background: Container(color: Colors.red),
                          child: SizedBox(
                            child: Card(
                              child: ListTile(
                                leading: FadeInImageWidget(
                                    photo: products[index]?.thumbnail ?? ''),
                                title: Text("${products[index]?.title}"),
                                subtitle: Text("\$${products[index]?.price}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteCheckout(
                                        products[index]!.id.toString());
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  const Center(
                    child: Text("cart is empty!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                if (products.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Price:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold)),
                            Row(children: [
                              Text("(${products.length} items)",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 18)),
                              const SizedBox(width: 4),
                              Text("\$$sumOfPrice ",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold))
                            ])
                          ]),
                      const SizedBox(height: 20),
                      MaterialButton(
                          shape: const StadiumBorder(),
                          height: 50,
                          padding: const EdgeInsets.all(5),
                          color: const Color.fromARGB(255, 255, 96, 96),
                          onPressed: () {},
                          child: const IconTextWidgetRow(
                              icon: Icons.shopping_cart_outlined,
                              text: "Proceed to Checkout",
                              align: MainAxisAlignment.center,
                              textColor: Colors.white,
                              color: Colors.white))
                    ]),
                  )
                else
                  const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
