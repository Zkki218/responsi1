import 'package:flutter/material.dart';
import 'package:responsi1/helpers/user_info.dart';
import 'package:responsi1/ui/login_page.dart';
import 'package:responsi1/ui/produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const ProdukPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi',
      theme: ThemeData(
        brightness: Brightness.dark,  // This affects overall text color
        primaryColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.blue[900],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[800]!,
          secondary: Colors.blue[600]!,
          surface: Colors.blue[900]!,
          // The following properties affect text colors:
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          // This affects text color in AppBar:
          foregroundColor: Colors.white,
        ),
        textTheme: Typography.whiteMountainView,  // This sets default text styles
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.blue[800],
          filled: true,
          // These affect text colors in text fields:
          labelStyle: TextStyle(color: Colors.blue[100]),
          hintStyle: TextStyle(color: Colors.blue[200]),
          // This affects the color of input text:
          // Add this line:
          floatingLabelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[600]!),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[400]!),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            // This affects text color on buttons:
            foregroundColor: Colors.white,
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.blue[800],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}