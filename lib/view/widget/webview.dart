import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../../global/global_constants.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final _logger = Logger();
  final progress = 0.obs;
  WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Obx(
                    () => progress.value != 100
                    ? LinearProgressIndicator(
                      color: Properties.primaryColor,
                  value: progress.value / 100,
                      backgroundColor: Colors.grey,
                )
                    : const SizedBox(),
              ),
            ),
            Expanded(
              flex: 100,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: url,
                onProgress: (value) {
                  progress.value = value;
                  _logger.d(value);
                },
                onWebResourceError: (error) {
                  errorSnackBar(context,'No Internet Connection');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
