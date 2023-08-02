import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Backend {
  Future<void> post_offer(
      {required String title,
      required String desc,
      required DateTime deadline}) async {
    try {
      await http.post(Uri.parse("http://127.0.0.1:8000/post_offer/"), body: {
        "title": title,
        "description": desc,
        "start": DateTime.now().toString(),
        "deadline": deadline.toString(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> accept_app({required int id}) async {
    try {
      await http.put(Uri.parse("http://127.0.0.1:8000/accept_app/$id/"));
    } catch (e) {
      print(e);
    }
  }

  Future<void> refuse_app({required int id}) async {
    try {
      await http.put(Uri.parse("http://127.0.0.1:8000/accept_app/$id/"));
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete_app({required int id}) async {
    try {
      await http.delete(Uri.parse("http://127.0.0.1:8000/delete_app/$id/"));
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
      return [offers, apps];
    } catch (e) {
      print(e);
    }
    return [[], []];
  }
}
