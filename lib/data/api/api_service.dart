import 'dart:convert';

import 'package:dicoding_restaurants/data/model/detail_restaurant_model.dart';
import 'package:dicoding_restaurants/data/model/restaurant_model.dart';
import 'package:dicoding_restaurants/data/model/search_restaurant_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String pictUrl = 'https://restaurant-api.dicoding.dev/images/medium/';

  Future<RestaurantModel> getListRestaurant() async {
    final response = await http.get(
      Uri.parse('${baseUrl}list'),
    );
    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SearchRestaurantModel> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('${baseUrl}search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailRestaurantModel> getRestaurantById(String id) async {
    final response = await http.get(Uri.parse('${baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      var data = dataJson['restaurant'];
      return DetailRestaurantModel.fromJson(data);
    } else {
      throw Exception('Failed to load detail data');
    }
  }
}
