import 'package:flutter/material.dart';

import '../../../global/global_constants.dart';
import '../../widget/common_toolbar.dart';
import '../../widget/my_radio_buton.dart';


class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  LanguageType? _languageType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: "About Somerian Health"),
      body: Column(

        children: [
          MyRadioButton(
            title: LanguageType.English.name,
            value: LanguageType.English,
            languageType: LanguageType.English,
            onChanged: (val){
              setState(() {
                _languageType=val;
              });
            },

          ),
          MyRadioButton(
            title: LanguageType.Arabic.name,
            value: LanguageType.Arabic,
            languageType: _languageType,
            onChanged: (val){
              setState(() {
                infoSnackBar(context, 'Coming soon');
                //_languageType=val;
              });
            },

          ),
        ],
      ),


    );
  }
}
