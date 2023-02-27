import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class Postsignup extends StatefulWidget {
  const Postsignup({super.key});

  @override
  State<Postsignup> createState() => _PostsignupState();
}

class _PostsignupState extends State<Postsignup> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void login(String email, password) async{
    //Response response =    post(Uri.parse('https://reqres.in/api/register'));
    try {
      http.Response response =await http.post(Uri.parse('https://reqres.in/api/register'),
      body: {
        'email' : email,
        'password' : password,
      }
      );
      if(response.statusCode == 200){
        // ignore: avoid_print
        print('Account created');
      }else{
        // ignore: avoid_print
        print('Failed');
      }
      
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('PostSignup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                hintText: 'Enter Your Email',
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordcontroller,
              decoration: const InputDecoration(
                hintText: 'Enter Your Password',
              ),
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: () {
                login(emailcontroller.text.toString(), passwordcontroller.text.toString());
                emailcontroller.clear();
                passwordcontroller.clear();
              },
              child: Container(
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child:  Text('Sign Up')),
              ),
            )

          ],
        ),
      ),    
    );

  }
}