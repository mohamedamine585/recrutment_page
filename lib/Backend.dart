import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Backend {
  Future<void> get_applications() async {
    try {
      print("object");
      Response response = await http.get(Uri.parse("http://127.0.0.1:8000/"));
      List<dynamic> applications = jsonDecode(response.body);
      List<Map<String, dynamic>> apps =
          applications.cast<Map<String, dynamic>>();
      print(apps);
      print(apps);
    } catch (e) {
      print(e);
    }
  }

  Future<List<List<Map<String, dynamic>>>> connect() async {
    try {
      Response appsresp, offersreps;
      appsresp = await http.get(Uri.parse("http://127.0.0.1:8000/get_apps"));
      offersreps =
          await http.get(Uri.parse("http://127.0.0.1:8000/get_offers"));
      List<Map<String, dynamic>> apps = [], offers = [];

      (json.decode(appsresp.body) as List<dynamic>).forEach((element) {
        apps.add(element);
      });
      (json.decode(offersreps.body) as List<dynamic>).forEach((element) {
        offers.add(element);
      });
      print(offers);
      print(apps);
      return [offers, apps];
    } catch (e) {
      print(e);
    }
    return [[], []];
  }
}
