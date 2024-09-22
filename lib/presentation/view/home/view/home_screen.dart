import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';
import 'package:mechine_test_pinkolearn/presentation/view/home/widgets/home_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
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
              childAspectRatio: 0.5,
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return  const HomeCardWidget();
          },
        ),
      ),
    );
  }
}
