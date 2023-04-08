import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/Products_model.dart';

class ProductExample extends StatefulWidget {
  const ProductExample({Key? key}) : super(key: key);

  @override
  State<ProductExample> createState() => _ProductExampleState();
}

class _ProductExampleState extends State<ProductExample> {


  Future<ProductsModel> getProductApi() async {
    final response = await http.get(Uri.parse('https://webhook.site/0d246301-b764-4f48-929c-f42e86776c5f'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductsModel>(
                future: getProductApi(),
                builder: (context , snapshot){
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context , index){
                        return Column(
                          children: [
                            Text(index.toString())
                          ],
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
