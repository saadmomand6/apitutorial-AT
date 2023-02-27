import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class Selfmademodelex extends StatefulWidget {
  const Selfmademodelex({super.key});

  @override
  State<Selfmademodelex> createState() => _SelfmademodelexState();
}

class _SelfmademodelexState extends State<Selfmademodelex> {
  List<Photos> postphotolist = [];
  Future<List<Photos>> getphotosdata() async{
    http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for (var i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        postphotolist.add(photos);
      }
      return postphotolist;
    }else{
      return postphotolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('selfmademodelexscreen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getphotosdata(),
              builder: ((context,AsyncSnapshot<List<Photos>> snapshot) {
                if (!snapshot.hasData) {
                  return const Text("loading plz wait");
                }else{
                  return ListView.builder(
                    itemCount: postphotolist.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: CircleAvatar( backgroundImage: NetworkImage(snapshot.data![index].url.toString()),),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title: Text('Number'+snapshot.data![index].id.toString()),
                        
                      );
                    }));
                }
              })))
            
        ],
      ),
    );
  }
}

class Photos{
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}