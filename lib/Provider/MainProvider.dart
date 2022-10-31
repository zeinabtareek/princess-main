import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:princess/Models/OfferModel.dart';
import 'package:princess/Models/OrderModel.dart';

import 'ServicesConfig.dart';

class MainProvider extends ChangeNotifier {
  List<OfferModel> offers = [];
  List<OfferModel> searchList = [];
  Map<String, dynamic> offerInfo = {};
  Map<String, dynamic> bookInfo = {};
  Map<String, dynamic> AppInfo = {};
  List<OrderModel> currentOrders = [];
  List<OrderModel> pastOrders = [];
  late OfferModel offer;

  Future<void> getCurrentOrders() async {
    var url = ServicesConfig.base_url + "/mybooks";
    var header = await ServicesConfig.getHeaderWithToken();
    try {
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200 && response.body != null) {
        print("enter ");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]
            ["data"]["current"];
        print(slideritems.length);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        currentOrders = slideritems.map((e) => OrderModel.fromJson(e)).toList();
        print(currentOrders.length);
        print("sssssssssssssssssssssssssssssssssssssssssssssssssss");
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPastOrders() async {
    var url = ServicesConfig.base_url + "/mybooks";
    var header = await ServicesConfig.getHeaderWithToken();
    try {
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200 && response.body != null) {
        print("enter");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]
            ["data"]["previous"];
        print(slideritems.length);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        pastOrders = slideritems.map((e) => OrderModel.fromJson(e)).toList();
        print(currentOrders.length);
        print("sssssssssssssssssssssssssssssssssssssssssssssssssss");
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOffers() async {
    var url = ServicesConfig.base_url + "/offers?paginate=true&limit=30";
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
  }

  String? content;

  String parseHtmlString(int index) {
    final document = parse(offers[index].description);
    content = parse(document.body!.text).documentElement!.text;
    print(content);
    return content!;
  }

  setOffer(OfferModel offerr) {
    this.offer = offerr;
    notifyListeners();
  }

  Future<void> search(var key) async {
    var url = ServicesConfig.base_url + "/search";
    var header = await ServicesConfig.getHeader();
    var body = {"name": key};
    try {
      final response =
          await http.post(Uri.parse(url), body: body, headers: header);
      if (response.statusCode == 200 && response.body != null) {
        print("enter ");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        List slideritems =
            json.decode(utf8.decode(response.bodyBytes))["data"]["data"];
        print(slideritems.length);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        searchList = slideritems.map((e) => OfferModel.fromJson(e)).toList();
        print(searchList.length);
        print("sssssssssssssssssssssssssssssssssssssssssssssssssss");
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOfferInfo(var id) async {
    String url = ServicesConfig.base_url + "/offer-details/$id";
    var header = await ServicesConfig.getHeader();
    try {
      final responce = await http.get(Uri.parse(url), headers: header);
      print(responce.body);
      if (responce.body.isNotEmpty) {
        offerInfo = json.decode(responce.body)["data"]["data"];
        print(offerInfo);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> cancelOrder(var id) async {
    String url = ServicesConfig.base_url + "/cancelBook/$id";
    print(url);
    var header = await ServicesConfig.getHeaderWithToken();
    try {
      final responce = await http.get(Uri.parse(url), headers: header);
      print(responce.body);
      if (responce.body.isNotEmpty) {
        print(json.decode(responce.body)["data"]["data"]);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> book(var offer_id, var paid_type, var date) async {
    String url = ServicesConfig.base_url + "/book";
    var header = await ServicesConfig.getHeaderWithToken();
    var body = {
      "offer_id": offer_id.toString(),
      "paid_type": paid_type,
      "date": date
    };
    print(body);
    print("--------------------------------------------");
    try {
      final responce =
          await http.post(Uri.parse(url), body: body, headers: header);
      print(responce.body);
      if (responce.body.isNotEmpty) {
        bookInfo = json.decode(responce.body);
        print(bookInfo);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getAppInfo() async {
    String url = ServicesConfig.base_url + "/info";
    var header = await ServicesConfig.getHeader();
    try {
      final responce = await http.get(Uri.parse(url), headers: header);
      print(responce.body);
      if (responce.body.isNotEmpty) {
        AppInfo = json.decode(responce.body)["data"]["data"];
        print(AppInfo);
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
