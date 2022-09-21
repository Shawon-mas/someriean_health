import 'package:flutter/material.dart';
import 'package:somerian_health/view/widget/common_toolbar.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Complete your profile',),
      body: SizedBox(),
    );
  }
}
