import 'package:flutter/material.dart';
import 'ShoppingListItem.dart';
import 'Product.dart';
import 'ghflutter.dart';

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time a widget appears at a given
  // location in the tree. If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses the State object
  // instead of creating a new State object.

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, you need to change
      //_shoppingCart inside a setState call to trigger a rebuild.
      // The framework then calls // build, below,
      // which updates the visual appearance of the app.

      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Shopping List'),
        ),
        body: new ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: widget.products.map((Product product) {
            return ShoppingListItem(
              product: product,
              inCart: _shoppingCart.contains(product),
              onCartChanged: _handleCartChanged,
            );
          }).toList(),
        ),
        bottomNavigationBar: _buildNavigationWidget(_selectedIndex),
      );
    } else if (_selectedIndex == 1) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Overview"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
//                MaterialPageRoute(builder: (context) => SecondRoute()),
                MaterialPageRoute(builder: (context) => GHFlutter()),
              );
            },
            child: Text('See Detail!'),
          ),
        ),
        bottomNavigationBar: _buildNavigationWidget(_selectedIndex),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Third Route"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              _showDialog();
            },
            child: Text('See Alert!'),
          ),
        ),
        bottomNavigationBar: _buildNavigationWidget(_selectedIndex),
      );
    }
  }

  Widget _buildNavigationWidget(int _selectedIndex) {
    return new BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          title: Text('Me'),
        ),
      ],
      currentIndex: _selectedIndex,
      fixedColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Within the SecondRoute widget
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}


