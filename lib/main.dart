import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mechine_test_pinkolearn/firebase_options.dart';
import 'package:mechine_test_pinkolearn/presentation/provider/auth_provider.dart'
    as local; // Prefix added
import 'package:mechine_test_pinkolearn/presentation/provider/product_provider.dart';
import 'package:mechine_test_pinkolearn/presentation/view/authentication/view/signup_screen.dart';
import 'package:mechine_test_pinkolearn/presentation/view/home/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => local.AuthProvider(), // Use prefix here
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: user != null ? HomeScreen() : SignupScreen(),
      ),
    );
  }
}
