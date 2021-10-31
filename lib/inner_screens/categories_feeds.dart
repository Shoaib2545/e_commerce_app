import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/widget/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CategoriesFeedsScreen extends StatelessWidget {
  static const routeName = '/CategoriesFeedsScreen';

  const CategoriesFeedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    print(categoryName);
    final productsList = productsProvider.findByCategory(categoryName);
    return Scaffold(
      body: productsList.isEmpty
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(FeatherIcons.database, size: 80,),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'No products related to this category',
                    // textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
          )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 240 / 420,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(productsList.length, (index) {
                return ChangeNotifierProvider.value(
                  value: productsList[index],
                  child: FeedProducts(),
                );
              }),
            ),
//         StaggeredGridView.countBuilder(
//           padding: ,
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) =>FeedProducts(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
    );
  }
}
