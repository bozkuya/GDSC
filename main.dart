import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _name = '';
  String _date = '';

Future<void> _addNewItem() async {
  final name = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter the product name'),
        content: TextField(
          onChanged: (value) {
            _name = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, _name);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );

  if (name != null) {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (date != null) {
      final newProduct = Product(name: name, date: date.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListPage(products: [newProduct]),
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Center(
              child: Text(
                'Home',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 150),
          Text(
            'Start with adding food to your fridge!',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Icon(
            Icons.fastfood,
            size: 180,
          ),
          Expanded(child: Container()),
          Padding(
  padding: const EdgeInsets.only(bottom: 10.0),
  child: Center(
    child: ElevatedButton(
  onPressed: _addNewItem, // change this line
  child: Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: Icon(
      Icons.add,
      size: 35,
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    shape: CircleBorder(),
    padding: EdgeInsets.all(0),
  ),
),

  ),
),

        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, size: 28),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                // Handle the Home option
              },
            ),
            ListTile(
              leading: Icon(Icons.kitchen, size: 28),
              title: Text(
                'My Fridge',
                style: TextStyle(fontSize: 20),
              ),
             onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductListPage(
        products: [
          Product(name: 'Milk', date: '04/05/2023'),
          Product(name: 'Eggs', date: '04/07/2023'),
          Product(name: 'Bread', date: '04/10/2023'),
        ],
      ),
    ),
  );
},
            ),

            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline, size: 28),
              title: Text(
                'About Application',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutApplicationPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AboutApplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'This application is for tracking your fridge food. You can add your food with an expiration date. You do not need to worry about spoilage of the food. The application will track for you. Enjoy it!',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
class ProductListPage extends StatefulWidget {
  final List<Product> products;

  ProductListPage({required this.products});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  void _deleteProduct(int index) {
    setState(() {
      widget.products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fridge'),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.products[index].name),
            subtitle: Text(widget.products[index].date),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteProduct(index);
              },
            ),
          );
        },
      ),
    );
  }
}


class Product {
  final String name;
  final String date;

  Product({required this.name, required this.date});
}