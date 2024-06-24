import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/form.dart';

class FormController {
  static const String URL =
      "https://script.google.com/macros/s/AKfycbxAyGiVn7Y9VbWKrEq4tu-7YHdD_roNC2L2Hv3smuzKxWhJO4rGn1akdrOijHucKCVV/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  void submitForm(FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      var body = feedbackForm.toJson();

      String json = convert.jsonEncode(body);

      print('Sending body: $body');
      print('Sending body: $json');
      
      var response = await http.post(
        Uri.parse(URL),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: json
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 302) {
        var url = response.headers['location'];
        response = await http.get(Uri.parse(url!));
        print('Redirected response status: ${response.statusCode}');
        print('Redirected response body: ${response.body}');
      }

      var decodedResponse = convert.jsonDecode(response.body);
      print('Decoded response: $decodedResponse');
      callback(decodedResponse['status']);
    } catch (e) {
      print(e);
    }
  }
}
