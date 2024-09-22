import 'package:flutter/material.dart';

class Constants {
///////////////////////collection name////////////////////

  static const collection = 'users';

  //////////////////colors///////////////
  static const Color primarycolor = Color(0xff0c54be);
  static const Color secondarycolor = Color(0xff303f60);
  static const Color ternarycolor = Color(0xfff5f9fd);
  static const Color backgroundcolor = Color.fromARGB(255, 234, 235, 238);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color baseColor = Color.fromARGB(255, 228, 225, 225);
}

/////////////////////////styles///////////////////////////
///
class Styles {
  static const TextStyle titlestyle =
      TextStyle(color: Constants.primarycolor, fontWeight: FontWeight.bold);

  static const TextStyle cardtitlestyle =
      TextStyle(color: Constants.black, fontWeight: FontWeight.bold);

  static const TextStyle hometitlestyle =
      TextStyle(color: Constants.white, fontWeight: FontWeight.bold);

  static const TextStyle textfieldhintstyle = TextStyle(
    color: Constants.black,
  );

  static const TextStyle buttontextstyle = TextStyle(
    color: Constants.white,
  );
  static const TextStyle textStyle = TextStyle(
    color: Constants.black,
  );
  static const TextStyle middtextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 14,
  );
  static const TextStyle hashStyle = TextStyle(
    decoration: TextDecoration.lineThrough,
    color: Colors.grey,
    fontSize: 12,
  );
  static TextStyle greenstyle = const TextStyle(
    color: Colors.green,
  );
}

///////////////////////////////space takers///////////////////////
class Spacetaker {
  static SizedBox hieght20 = const SizedBox(
    height: 20,
  );
}

////////////////////////regx //////////////////////////////////
class Regx {
  static final usernameRegExp = RegExp(r'^[a-zA-Z0-9]{6,12}$');

  static final password = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  static final RegExp regemail =
      RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");
}
