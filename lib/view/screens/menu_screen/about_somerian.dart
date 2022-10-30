import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/properties.dart';
import '../../widget/common_toolbar.dart';
import '../../widget/text_widget.dart';
class AboutSomerian extends StatelessWidget {
  const AboutSomerian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var date="<p>While the nation was fighting the virus outbreak,</p><p>Somerian Health as a volunteer healthcare body came</p><p>forward to join forces with the civic body.</p><p>Ever since then, Somerian Health has been ensuring</p><p>effective prevention and control of COVID-19 in every</p><p>possible way. This includes diagnostic services like</p><p>RT-PCR, DPI testing, airport watch tracker programs and</p><p>antigen testing.</p><p>Headquartered in Abu Dhabi, Somerian Health &mdash; a</p><p>subsidiary of TAMOUH and the renowned IHC group of</p><p>companies &mdash; takes pride in being a leading force</p><p>throughout the pandemic by setting up 84 Covid-care</p><p>field hospitals, ICUs and clinical laboratories.</p><p>Somerian health has been organizing vaccination drives</p><p>at various touchpoints like airports, borders, churches,</p><p>gurdwaras and labour camps &ndash; only to make UAE feel</p><p>safe again</p><p><br></p><p><br></p> ";
    return Scaffold(
      appBar: CommonToolbar(title: "About Somerian Health"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: Image.asset(
                "assets/images/main_logo.png",
              ),
            ),
          ),
        // Html(data: date),
        ],
      ),
    );
  }
}
