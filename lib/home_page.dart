import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   File? image;
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imagePermanently = await saveImagePermanently(image.path);
    setState(() => this.image = imagePermanently);
  }

  
  takepicc() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      {
        final images = File(image.path);
        GallerySaver.saveImage(image.path, albumName: 'cr7');
      }
    });
  }

  Future<File> saveImagePermanently(String imagepath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagepath);
    final image = File('${directory.path}/$name');
    return File(imagepath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: IconButton(
            onPressed: () => takepicc(),
            icon: const Icon(
              Icons.camera_alt_outlined,
              size: 40,
            )),
        
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  image != null
                      ? Image.file(image!)
                      : const Card(
                          color: Color.fromARGB(255, 251, 252, 251),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: 
      Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(  
          
          backgroundColor: Colors.black,
          
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: const Icon(Icons.image),
                   
                  ),
      ),
          
        
        
        
      );

    
  }
}



