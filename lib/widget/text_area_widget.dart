import 'package:flutter/material.dart';

class TextAreaWidget extends StatelessWidget {
  final String text;

  const TextAreaWidget({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all()),
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: SelectableText(
                text == null ? 'Scan an Image to get text' : text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
}
