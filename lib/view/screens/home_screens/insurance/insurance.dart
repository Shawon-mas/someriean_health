import 'package:flutter/material.dart';

import '../../../widget/common_toolbar.dart';
class Insurance extends StatelessWidget {
  const Insurance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Insurance'),
      body: Container(
        child: Image.asset('assets/images/menu.JPG'),
      ),
    );
  }
}
