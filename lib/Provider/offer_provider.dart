import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:princess/Models/OfferModel.dart';
import 'package:princess/Provider/ServicesConfig.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfferProvider extends ChangeNotifier {
  final RefreshController refreshController = RefreshController();
  List<OfferModel> offers = [];
  bool loading = true;
  int num = 10;

  Future<void> getOffers() async {
    loading = true;
    var url = ServicesConfig.base_url + "/offers?paginate=true&limit=$num";
    var header = await ServicesConfig.getHeader();
    try {
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200 && response.body != null) {
        print("enter ");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        List slideritems =
            json.decode(utf8.decode(response.bodyBytes))["data"]["data"];
        print(slideritems.length);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        offers = slideritems.map((e) => OfferModel.fromJson(e)).toList();
        print(offers.length);
        print("sssssssssssssssssssssssssssssssssssssssssssssssssss");
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  loadMore() async {
    if (offers.isNotEmpty) {
      num += 10;
      notifyListeners();
      var url = ServicesConfig.base_url + "/offers?paginate=true&limit=$num";
      var header = await ServicesConfig.getHeader();
      try {
        final response = await http.get(Uri.parse(url), headers: header);
        if (response.statusCode == 200 && response.body != null) {
          print("enter ");
          print(json.decode(utf8.decode(response.bodyBytes))["data"]);

          List slideritems =
              json.decode(utf8.decode(response.bodyBytes))["data"]["data"];
          print(slideritems.length);
          print("++++++++++++++++++++++++++++++++++++++++++++");
          offers = slideritems.map((e) => OfferModel.fromJson(e)).toList();
          print(offers.length);
          print("sssssssssssssssssssssssssssssssssssssssssssssssssss");
          notifyListeners();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("loading");
    }
  }

  String? content;

  String parseHtmlString(int index) {
    final document = parse(offers[index].description);
    content = parse(document.body!.text).documentElement!.text;
    return content!;
  }
}
