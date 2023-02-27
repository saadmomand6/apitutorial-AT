import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;


class Withoutmodel extends StatefulWidget {
  const Withoutmodel({super.key});

  @override
  State<Withoutmodel> createState() => _WithoutmodelState();
}

class _WithoutmodelState extends State<Withoutmodel> {
   var data;
  Future getdata() async{
    http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }else{
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Withoutmodel'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdata(),
            builder: ((context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Text("loading");
              }else{
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: Column(
                        children: [
                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Name",style: TextStyle(fontSize: 20),),
                                Text(data[index]['name'].toString()),
                            ],),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Email",style: TextStyle(fontSize: 20),),
                                Text(data[index]["email"].toString()),
                            ],),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Address",style: TextStyle(fontSize: 20),),
                                Text(data[index]["address"]["street"].toString()),
                            ],),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Phone",style: TextStyle(fontSize: 20),),
                                Text(data[index]["phone"].toString()),
                            ],),
                            
                        ],
                      ),
                    );
                  }));
              }
            })))
        ],
      ),
    );
  }
}