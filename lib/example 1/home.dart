import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:apitutorial/example 1/model1/examplemodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Examplemodel> postlist = [];

  Future<List<Examplemodel>> getdata() async{
    http.Response response = await  http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      
      
      // var body = data['body'];
      // var title = data['title'];
      // var id = data['id'];
      // var userid = data['userid'];
      //postlist.add(data);
      for(var i in data){
        postlist.add(Examplemodel.fromJson(i));
      } 
      return postlist;
    }else{
      return postlist;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('homescreen'),
      ),
      body: Column(
        children:[
          Expanded(
            child: FutureBuilder(
              future: getdata(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("loading plz wait");
                }else{
                  return ListView.builder(
                    itemCount: postlist.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          //  Text(postlist[index]['id'].toString()),
                          //  Text(postlist[index]["title"].toString()),
                          Text(postlist[index].id.toString()),
                          Text(postlist[index].title.toString()),
                        ],
                      );
                    }));
                }
          
            })),
          )
        ],
      ),
    );
  }
}