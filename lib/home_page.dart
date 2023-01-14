import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

final translator = GoogleTranslator();
TextEditingController myController = TextEditingController();
String? _dropdownvalue;
String? translated_text;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translator App"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Expanded( 
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 80,
                  child: TextField(
                    maxLines: 20,
                    focusNode: FocusNode(canRequestFocus: false),
                    controller: myController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Text",
                        fillColor: Colors.grey[300],
                        filled: true),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: DropdownButton(
                    isExpanded: true,
                    hint: _dropdownvalue == null
                        ? Text("Select language")
                        : Text(
                            _dropdownvalue!,
                            style: TextStyle(color: Colors.blue),
                          ),
                    items: <String>["English", "Spanish", "China", "German"]
                        .map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Container(child: Text(value)),
                      );
                    }).toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        _dropdownvalue = newvalue;
                      });
                      if (_dropdownvalue == "English") {
                        translate_text('en');
                      } else if (_dropdownvalue == 'Spanish') {
                        translate_text('es');
                      } else if (_dropdownvalue == 'China') {
                        translate_text('zh-cn');
                      } else if (_dropdownvalue == 'German') {
                        translate_text('de');
                      }
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.bottomLeft,
                  child: translated_text != null
                      ? Text(
                          translated_text!,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'Translated Text Here',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void translate_text(String local) {
    translator.translate(myController.text, to: local).then((value) {
      setState(() {
        translated_text = value.text;
      });
    });
  }
}
