import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/presentation/provider/auth_provider.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/view/login_screen.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/widgets/main_button.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/widgets/main_textfield.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';
import 'package:mechine_test_pinkolearn/presentation/view/home/view/home_screen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
        titleTextStyle: Styles.titlestyle,
        backgroundColor: Constants.backgroundcolor,
        title: const Text(
          "e-Shop",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                MainTextfield(
                  controller: name,
                  hinttext: "Name",
                  keyboard: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    } else if (!Regx.usernameRegExp.hasMatch(value)) {
                      return 'Username must be 6-12 alphanumeric characters';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: MainTextfield(
                    controller: email,
                    hinttext: "Email",
                    keyboard: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid email";
                      } else if (!Regx.regemail.hasMatch(value)) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                MainTextfield(
                  controller: password,
                  hinttext: "Password",
                  keyboard: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    } else if (!Regx.password.hasMatch(value)) {
                      return 'Password must be at least 8 characters long, include at least one lowercase letter and one number';
                    } else {
                      return null;
                    }
                  },
                ),
                const Spacer(),
                MainButton(
                  onpressed: () async {
                    if (authProvider.isLoading) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Please Wait...')),
                        );
                    }
                    if (formKey.currentState!.validate()) {
                      await authProvider
                          .signUp(
                              name: name.text.trim(),
                              email: email.text.trim(),
                              password: password.text.trim())
                          .then(
                        (value) {
                          if (authProvider.status == Status.error) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(content: Text(authProvider.error)),
                              );
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()));
                          }
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Signup",
                    style: Styles.buttontextstyle,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? ",
                            style: Styles.textStyle),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()));
                            },
                            child: const Text("Login", style: Styles.titlestyle))
                      ],
                    )),
                Spacetaker.hieght20
              ],
            ),
          ),
        ),
      ),
    );
  }
}
