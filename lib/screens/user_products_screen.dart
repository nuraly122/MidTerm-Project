import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .getProductsFromDB(true);
  }

  @override
  Widget build(BuildContext context) {
//    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _onRefresh(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx,productsData,_)=> Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.itemsList.length,
                          itemBuilder: (_, i) => Column(
                            children: <Widget>[
                              UserProductItem(
                                id: productsData.itemsList[i].id,
                                title: productsData.itemsList[i].title,
                                imageUrl: productsData.itemsList[i].imageUrl,
                              ),
                              Divider()
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
