import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/product.dart';
import 'detailscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.http("fakestoreapi.com", "products");
    var response = await http.get(url);
    //print(response.body);
    setState(() {
      products = productFromJson(response.body);
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IT@WU Shop"),
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];
            var imgUrl = product.image;
            imgUrl ??=
                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-20.jpg";
            return ListTile(
              title: Text("${product.title}"),
              subtitle: Text("\$${product.price}"),
              leading: AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(imgUrl),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(),
                        settings: RouteSettings(arguments: product)));
              },
            );
          }),
    );
  }
}
