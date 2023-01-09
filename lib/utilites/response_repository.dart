import 'package:http/http.dart' as http;

import 'api_services.dart';

Future<http.Response?> authPost({required String url, required Map<String, dynamic> body}) async {
  var response = await http.post(Uri.parse(url), body: body, headers: await ApiServices().headerWithToken());
  if (response.statusCode == 200) {
    return response;
  } else
    return null;
}

Future<http.Response?> generalGet({required String url}) async {
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response;
  } else
    return null;
}
