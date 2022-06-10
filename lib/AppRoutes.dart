import 'package:ecommerce_app/Screens/Home_Screen.dart';
import 'package:ecommerce_app/layouts/screen_layout.dart';
import 'package:ecommerce_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';



class AppRoutes {
   static const String authScreen = '/auth_screen';
   static const String screenlayout = '/screen_layout';
   static const String HomeScreen= '/Home_Screen';


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return _buildRoute(const auth_screen(), settings);      
      // case screenlayout:
      //   return _buildRoute(const screen_layout(), settings);
         case HomeScreen:
        return _buildRoute(const Home_Screen(), settings);
      default:
        return _buildRoute(const Scaffold(), settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}