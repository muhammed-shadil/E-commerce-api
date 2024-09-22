import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/presentation/provider/auth_provider.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/view/signup_screen.dart';
import 'package:mechine_test_pinkolearn/presentation/view/home/view/home_screen.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/widgets/main_button.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/widgets/main_textfield.dart';
import 'package:mechine_test_pinkolearn/core/constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleTextStyle: Styles.titlestyle,
        backgroundColor: Constants.backgroundcolor,
        title: const Text("e-Shop"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: mediaQuery.size.height -
                mediaQuery.padding.top -
                kToolbarHeight,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: MainTextfield(
                        controller: email,
                        hinttext: "Email",
                        keyboard: TextInputType.emailAddress,
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
                      keyboard: TextInputType.visiblePassword,
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
                        if (formKey.currentState!.validate()) {
                          if (authProvider.status == Status.initial) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(content: Text('Please Wait...')),
                              );
                          }
                          await authProvider
                              .logIn(
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
                              } else if (authProvider.status ==
                                  Status.loggedIn) {
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
                        "Login",
                        style: Styles.buttontextstyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New here? ", style: Styles.textStyle),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignupScreen()));
                            },
                            child: const Text("Signup",
                                style: Styles.authbuttonstyle),
                          ),
                        ],
                      ),
                    ),
                    Spacetaker.hieght20,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
