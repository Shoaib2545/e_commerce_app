import 'package:e_commerce_app/inner_screens/product_details.dart';
import 'package:e_commerce_app/provider/orders_provider.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/screens/wishlist/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inner_screens/brands_navigation_rail.dart';
import 'inner_screens/categories_feeds.dart';
import 'screens/auth/forget_password.dart';
import 'screens/orders/order.dart';
import 'screens/upload_product_form.dart';
import 'provider/cart_provider.dart';
import 'provider/favs_provider.dart';
import 'screens/auth/login.dart';
import 'screens/auth/sign_up.dart';
import 'screens/bottom_bar.dart';
import 'screens/cart/cart.dart';
import 'screens/feeds.dart';
import 'screens/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
            ],
            child: MaterialApp(
                  title: 'Shop App',
                  home: const UserState(),
                  //initialRoute: '/',
                  routes: {
                    //   '/': (ctx) => LandingPage(),
                    'brands_navigation_rail': (ctx) =>const BrandNavigationRailScreen(),
                    'CartScreen': (ctx) => const CartScreen(),
                    'Feeds': (ctx) => const Feeds(),
                    'WishlistScreen' : (ctx) => const WishlistScreen(),
                    'ProductDetails': (ctx) => const ProductDetails(),
                    'CategoriesFeedsScreen': (ctx) => const CategoriesFeedsScreen(),
                    'LoginScreen' :(ctx) => const LoginScreen(),
                    'SignUpScreen': (ctx) => const SignUpScreen(),
                    'BottomBarScreen': (ctx) => const BottomBarScreen(),
                    'UploadProductForm': (ctx) => const UploadProductForm(),
                    'ForgetPassword': (ctx) => const ForgetPassword(),
                    'OrderScreen': (ctx) => const OrderScreen(),
                  },
                )
          );
        });
  }
}