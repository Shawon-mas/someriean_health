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
    return Scaffold(
      appBar: CommonToolbar(title: "About Somerian Health"),
      body: SingleChildScrollView(
        child: Column(
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
            Html(
                data:
                    """<p align="justify">While the nation was fighting the virus outbreak, Somerian Health as a volunteer healthcare body came forward to join forces with the civic body.</p>
      <p align="justify">Ever since then, Somerian Health has been ensuring effective prevention and control of COVID-19 in every possible way. This includes diagnostic services like RT-PCR, DPI testing, airport watch tracker programs and antigen testing.</p>
      <p align="justify">Headquartered in Abu Dhabi, Somerian Health &mdash; a subsidiary of TAMOUH and the renowned IHC group of companies &mdash; takes pride in being a leading force field hospitals, ICUs and clinical laboratories.</p>
      <p align="justify">Somerian health has been organizing vaccination drives at various touchpoints like airports, borders, churches, gurdwaras and labour camps &ndash; only to make UAE feel safe again</p>
      """),
          ],
        ),
      ),
    );
  }
}
