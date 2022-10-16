import 'package:flutter/material.dart';
import 'package:somerian_health/view/widget/common_toolbar.dart';
class Location extends StatelessWidget {
  const Location({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Find us'),
    );
  }
}
