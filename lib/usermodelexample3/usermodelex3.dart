import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:apitutorial/usermodelexample3/model3/usermodelexample3.dart';
class UsermodelExample3 extends StatefulWidget {
  const UsermodelExample3({super.key});

  @override
  State<UsermodelExample3> createState() => _UsermodelExample3State();
}

class _UsermodelExample3State extends State<UsermodelExample3> {
  
  List<Usermodelexample3> usermodellist = [];
  Future<List<Usermodelexample3>> getusermodeldata() async{

    http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(var i in data){
        usermodellist.add(Usermodelexample3.fromJson(i));
      }
      return usermodellist;
    }else{
      return usermodellist;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('usermodelex3screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getusermodeldata(),
              builder: ((context,AsyncSnapshot<List<Usermodelexample3>> snapshot) {
                if(!snapshot.hasData){
                  return const Text('Loading plz wait');
                }else{
                  return ListView.builder(
                  itemCount: usermodellist.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              const Text("Name",style: TextStyle(fontSize: 20),),
                            Text(snapshot.data![index].name.toString()),
                            ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Email",style: TextStyle(fontSize: 20),),
                            Text(snapshot.data![index].email.toString()),
                            ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Address",style: TextStyle(fontSize: 20),),
                            Text(snapshot.data![index].address!.city.toString() + snapshot.data![index].address!.geo!.lat.toString()),
                            ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Phone",style: TextStyle(fontSize: 20),),
                            Text(snapshot.data![index].phone.toString()),
                            ],),
                          ],)
                        ],
                      ),
                    );
                  
                }));
                }
                
              })) 
            ),
        ],
      ),
    );
  }
}