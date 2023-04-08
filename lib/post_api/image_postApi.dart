import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  File? image ;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if(pickFile!= null){
      image = File(pickFile.path);
      setState(() {

      });
    }else{
      print('no image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    
    var request =  http.MultipartRequest('POST', uri);
    request.fields['title'] = 'Static title' ;

    var multiport =  http.MultipartFile(
        'image',
        stream,
        length);

    request.files.add(multiport);
    var response = await request.send();
    if(response.statusCode == 200){
      setState(() {
        showSpinner = false;
      });
      print('Image Uploaded');
    }else{
      setState(() {
        showSpinner = false;
      });
      print('failed');
    }

  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Container(
                  child: image == null ? const Center(child: Text('Pick Image'),)
                      :
                  Container(
                    child: Center(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                ),
              ),
              const SizedBox(height: 100.0,),
              GestureDetector(
                onTap: (){
                  uploadImage();
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 30.0,
                  width: 100.0,
                  child: Center(child: Text('Upload')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
