
//this is the example of the get api without model

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gert_post_api_prac/get_api/compenent/reusable_row.dart';
import 'package:http/http.dart' as http;

class WithoutModel extends StatefulWidget {
  const WithoutModel({Key? key}) : super(key: key);

  @override
  State<WithoutModel> createState() => _WithoutModelState();
}

class _WithoutModelState extends State<WithoutModel> {

  var data;
  Future<void> getUserApiWM() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Without Model'),
      ),
      body: Column(
        children: [
          Expanded(
              child:FutureBuilder(
                future: getUserApiWM(),
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Text('Loading...');
                  }else{
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context , index){
                            return Container(
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(color: Colors.black,blurRadius: 5.0),
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ReusableRow(title: 'Name', value: data[index]['name'].toString()),
                                      ReusableRow(title: 'UserName', value: data[index]['username'].toString()),
                                      ReusableRow(title: 'Email', value: data[index]['email'].toString()),
                                      ReusableRow(title: 'Phone No', value: data[index]['phone'].toString()),
                                      ReusableRow(title: 'Address',
                                          value:data[index]['address']['suite'].toString()+ '\n'+
                                          data[index]['address']['street'].toString()+'\n'+
                                          data[index]['address']['city'].toString()+'\n'+
                                          data[index]['address']['zipcode'].toString()
                                      ),
                                      ReusableRow(title: 'Geo', value: data[index]['address']['geo'].toString()),
                                    ],
                                  ),
                                ),
                              ),
                            );
                      })
                    );
                  }
                },
              )
          ),
        ],
      ),
    );
  }
}
