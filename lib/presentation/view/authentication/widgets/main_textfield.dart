import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';

class MainTextfield extends StatelessWidget {
  const MainTextfield(
      {super.key,
      required this.hinttext,
      required this.keyboard,
      required this.validator,
      this.controller});
  final String hinttext;
  final TextInputType keyboard;
  final TextEditingController? controller;
  final String? Function(dynamic value) validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          TextFormField(
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            controller: controller,
            validator: validator,
            keyboardType: keyboard,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              errorMaxLines: 3,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              hintText: hinttext,
              hintStyle: Styles.textfieldhintstyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              fillColor: Constants.ternarycolor,
              filled: true,
            ),
          )
        ],
      ),
    );
  }
}
