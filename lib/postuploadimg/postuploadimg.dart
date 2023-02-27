// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class Postuploadimg extends StatefulWidget {
  const Postuploadimg({super.key});
  @override
  State<Postuploadimg> createState() => _PostuploadimgState();
}

class _PostuploadimgState extends State<Postuploadimg> {
  //used for image path:=
  File? image;
  final _picker = ImagePicker();
  bool showspinner = false;

  //to get the image:=
  Future getimage() async{
    final pickedfile =await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedfile!=null) {
      //to store path:=
      image = File(pickedfile.path);
      setState(() {});
    }else{
      return  const Text('no image selected');
    }
  }

  //to upload the image
  Future<void> uploadimage() async{
    setState(() {
      showspinner=true;
    });
    //image ko stream ki tarha read krna ha:=
  var stream = http.ByteStream(image!.openRead());
  stream.cast();
  var length = await image!.length();
  var url = Uri.parse('https://fakestoreapi.com/products'); 
  //a request for server:= 
  var request = http.MultipartRequest('POST', url) ;
  request.fields["title"] = "static title";
  //to assign image:=
  var multiport = http.MultipartFile("images", stream, length);
  request.files.add(multiport);
  var response = await request.send();
  if (response.statusCode == 200) {
    setState(() {
      showspinner=false;
    });
     print('Image Uploaded');
  }else{
    setState(() {
      showspinner=false;
    });
     print('Upload Failed');
  }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Upload Img'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getimage();
              },
              child: Container(
                child: image==null ? const Center(child: Text('Select Image'),) : Container(
                 //to show image:=
                  child: Center(child: Image.file(File(image!.path).absolute,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  ),),
                )
              ),
            ),
            const SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                uploadimage();
              },
              child: Container(
                height: 50,
                width: 80,
                color: Colors.pink,
                child: const Center(child: Text("Upload"),),),
            )

    
          ],
        ),
      ),
    );
  }
}