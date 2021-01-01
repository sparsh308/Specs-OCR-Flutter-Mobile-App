import 'package:bot_toast/bot_toast.dart';
import 'package:OcrSpecs/fadeanimation.dart';
import 'package:OcrSpecs/auth.dart';
import 'package:OcrSpecs/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:OcrSpecs/widget/text_area_widget.dart';
import 'package:translator/translator.dart';

import 'language.dart';

class Result extends StatefulWidget {
  String text;
  Result({this.text});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String text2;
  final translator = GoogleTranslator();
  List<Language> _languages = Language.getlanguages();

  List<DropdownMenuItem<Language>> _dropdownMenuItems;

  Language _selectedlangauge;
  String _selectedlangaugecode;

  @override
  void initState() {
    text2 = widget.text;
    _dropdownMenuItems = buildDropdownMenuItems(_languages);
    _selectedlangauge = _dropdownMenuItems[0].value;
    print(_selectedlangauge.name);
    super.initState();
  }

  List<DropdownMenuItem<Language>> buildDropdownMenuItems(List languages) {
    List<DropdownMenuItem<Language>> items = List();
    for (Language language in languages) {
      items.add(
        DropdownMenuItem(
          value: language,
          child: Text(language.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Language selectedCompany) {
    String result;
    setState(() {
      _selectedlangauge = selectedCompany;
      _selectedlangaugecode = selectedCompany.code;
    });
    translator.translate(text2, to: _selectedlangaugecode).then((value) {
      result = value.toString();
      print(result);
      setState(() {
        text2 = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Specs",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "OCR",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  return showDialog(
                      context: (context),
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          content: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "Specs",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "OCR",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Version 1.0',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Developed by Sparsh Kishore Kumar',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "Developed on Flutter",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                })
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: TextAreaWidget(
                  text: text2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      if (widget.text.trim() != '') {
                        FlutterClipboard.copy(widget.text);
                      }
                    }),
                Image.asset(
                  "assets/translate.png",
                  height: 40,
                ),
                DropdownButton(
                  value: _selectedlangauge,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
              ],
            )
          ],
        ));
  }
}
