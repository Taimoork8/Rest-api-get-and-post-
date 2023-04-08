import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/post_model.dart';

class HomeScreenG extends StatefulWidget {
  const HomeScreenG({Key? key}) : super(key: key);

  @override
  State<HomeScreenG> createState() => _HomeScreenGState();
}

class _HomeScreenGState extends State<HomeScreenG> {

  List<PostsModel> postList = [];
//this is for hitting the Api and if the array doesn't have name in the api
// than we will define one like postList
  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context , snapshot){
                if(!snapshot.hasData){
                  return const Text('Loading...');
                }else{
                   return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context , index){
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                              Text(postList[index].title.toString()),
                              SizedBox(height: 10.0),
                              Text('Description',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                              Text(postList[index].body.toString()),
                            ]
                          )
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
