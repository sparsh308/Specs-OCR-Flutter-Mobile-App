import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:OcrSpecs/api/firebase_ml_api.dart';
import 'package:OcrSpecs/widget/text_area_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:OcrSpecs/result.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:translator/translator.dart';

import 'controls_widget.dart';
import 'package:OcrSpecs/scanner_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _animationStopped = false;
  String scanTexts = "Scan";
  bool scanning = false;

  @override
  void initState() {
    _animationStopped = true;
    scanning = false;
    _animationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });
    super.initState();
  }

  String text = '';
  File image;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            const SizedBox(height: 30),
            FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: () {
                pickImagex2();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  height: 50,
                  onPressed: () {
                    scanText();
                  },
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scan Text",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  textColor: Colors.white,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  height: 50,
                  onPressed: () {
                    pickImage();
                  },
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pick Image",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  textColor: Colors.white,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  height: 50,
                  onPressed: () {
                    clear();
                  },
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Clear Image",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildImage() => Container(
        child: image != null
            ? Stack(children: [
                Image.file(image),
                ImageScannerAnimation(
                  _animationStopped,
                  334,
                  animation: _animationController,
                )
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image.png",
                    height: 75,
                  ),
                  Text(
                    "No Image Selected",
                    style: TextStyle(color: Colors.white54),
                  )
                ],
              ),
      );

  pickImage() async {
    setState(() {
      scanning = false;
      _animationStopped = true;
    });
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
  }

  pickImagex2() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(file.path));
  }

  scanText() async {
    if (!scanning) {
      animateScanAnimation(false);
      setState(() {
        _animationStopped = false;
        scanning = true;
        scanTexts = "Stop";
        print(_animationStopped);
      });
    } else {
      setState(() {
        _animationStopped = true;
        scanning = false;
        scanTexts = "Scan";
      });
    }

    if (image != null) {
      final text = await FirebaseMLApi.recogniseText(image);
      setText(text);

      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          scanning = false;
          _animationStopped = true;
        });
// Here you can write your code
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Result(
                      text: text,
                    )));
      });
    } else {
      BotToast.showText(text: "No Image Selected");
    }
  }

  void clear() {
    setImage(null);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
