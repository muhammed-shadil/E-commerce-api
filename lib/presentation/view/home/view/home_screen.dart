import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';
import 'package:mechine_test_pinkolearn/presentation/provider/auth_provider.dart';
import 'package:mechine_test_pinkolearn/presentation/provider/product_provider.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/view/login_screen.dart';
import 'package:mechine_test_pinkolearn/presentation/view/home/widgets/home_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<ProductProvider>(context, listen: false).fetchproduts();
  }

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.status == Status.loggedOut) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        },
      );
    }
    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  authProvider.logOut();
                },
                icon: const Icon(Icons.logout_outlined)),
          )
        ],
        automaticallyImplyLeading: false,
        titleTextStyle: Styles.hometitlestyle,
        backgroundColor: Constants.primarycolor,
        title: const Text(
          "e-Shop",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.55,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: productprovider.products!.products.length,
          itemBuilder: (BuildContext context, int index) {
            return productprovider.isLoading
                ? Shimmer.fromColors(
                    baseColor: Constants.white,
                    highlightColor: Constants.baseColor,
                    child: Container(
                      height: 120,width: 100,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                :  productprovider.products == null
                ? Center(child: Text('No products available.')) :
                 HomeCardWidget(
                    productprovider: productprovider,
                    index: index,
                  );
          },
        ),
      ),
    );
  }
}
