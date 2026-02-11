// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'screens/login_screen.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'AWAR Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Tajawal', // يمكنك استخدام خط عربي إذا أردت
        ),
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: child,
          );
        },
      ),
    );
  }
}
