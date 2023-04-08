//this is when we can make the model of api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'compenent/reusable_row.dart';
import 'models/User_model.dart';


class UserExample extends StatefulWidget {
  const UserExample({Key? key}) : super(key: key);

  @override
  State<UserExample> createState() => _UserExampleState();
}

class _UserExampleState extends State<UserExample> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Example'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context , AsyncSnapshot<List<UserModel>> snapshot){
                  if(!snapshot.hasData){
                    return const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }else{
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context , index){
                          return Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.black,blurRadius: 10.0),
                              ]
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Name', value: snapshot.data![index].name.toString(),),
                                    ReusableRow(title: 'username', value: snapshot.data![index].username.toString(),),
                                    ReusableRow(title: 'email', value: snapshot.data![index].email.toString(),),
                                    ReusableRow(title: 'website', value: snapshot.data![index].website.toString(),),
                                    ReusableRow(title: 'Address',
                                      value: snapshot.data![index].address!.city.toString()+ ' '+
                                          snapshot.data![index].address!.geo!.lat.toString()+
                                          snapshot.data![index].address!.geo!.lng.toString()
                                    ),
                                  ]),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
