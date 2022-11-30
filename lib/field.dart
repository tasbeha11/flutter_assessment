import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'pick.dart';


class filefield extends StatefulWidget {

  filefield(this.title, this.selection, this.i);

  final bool selection;
  final String title;
  final int i;

  @override
  State<filefield> createState() => _filefieldState();
}

class _filefieldState extends State<filefield> {

  final ImagePicker _picker = ImagePicker();
  dynamic pageImage;

  buttonCheck(){
    counter++;
    if(counter == 4){
      setState(() {
        check = true;
      });
    }
    else{}
  }

  _pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if(pickedFile != null){
      buttonCheck();
      setState(() {
        image = File(pickedFile.files.single.path.toString());
      });
      print(counter);
      _renderImage();
    }
    else{}
  }

  _renderImage() async {
    final document = await PdfDocument.openFile(image!.path);
    final page = await document.getPage(1);
    final pageRender = await page.render(width: page.width, height: page.height);

    setState(() {
      pageImage = pageRender!.bytes;
    });
    await page.close();
  }

  _pickImage(ImageSource src) async {

    final XFile? result = await _picker.pickImage(source: src);
    buttonCheck();
    setState(() {
      image = File(result!.path);
    });
    print(counter);
  }
  bool switcher = false;
  File? image;
  @override
  Widget build(BuildContext context) {
    if(widget.selection == false) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: (){
                showModalBottomSheet(context: context, builder: (context){
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: IconButton(
                              onPressed: (){
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.camera_alt_outlined, size: 40.0, color: Colors.blue,)),
                        ),
                        Text(
                          'Or',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0,
                              fontFamily: 'Alexandria'),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: IconButton(
                              onPressed: (){
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                                setState(() {
                                  progressWidget[widget.i].containerColor = Colors.cyan;
                                });
                              },
                              icon: Icon(Icons.folder_copy_outlined, size: 40.0, color: Colors.blue,)),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                height: 65.0,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.title}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        image != null ? Container(
                          child: Image.file(image!, fit: BoxFit.cover,),
                          height: 55,
                          width: 48,
                        ) : Container()
                      ],
                    )
                ),
              )
          ),
        ),
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context){
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: IconButton(
                              onPressed: (){
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                                setState(() {

                                  switcher = true;
                                  progressWidget[widget.i].containerColor = Colors.cyan;
                                });
                              },
                              icon: Icon(Icons.camera_alt_outlined, size: 40.0, color: Colors.blue,)),
                        ),
                        Text(
                          'Or',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0,
                              fontFamily: 'Alexandria'),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: IconButton(
                              onPressed: (){
                                _pickFile();
                                Navigator.pop(context);
                                setState(() {
                                  progressWidget[widget.i].containerColor = Colors.cyan;
                                });
                              },
                              icon: Icon(Icons.folder_copy_outlined, size: 40.0, color: Colors.blue,)),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: switcher != true ? Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                height: 65.0,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.title}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        image != null && pageImage !=null ? Container(
                          child: Image(image: MemoryImage(pageImage), fit: BoxFit.fill,),
                          height: 55,
                          width: 48,
                        ) : Container()
                      ],
                    )
                ),
              ) : Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                height: 65.0,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.title}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        image != null ? Container(
                          child: Image.file(image!, fit: BoxFit.cover,),
                          height: 55,
                          width: 48,
                        ) : Container()
                      ],
                    )
                ),
              )
          ),
        ),
      );
    }
  }
}