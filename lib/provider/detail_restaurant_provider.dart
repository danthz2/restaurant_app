import 'dart:io';

import 'package:dicoding_restaurants/data/model/detail_restaurant_model.dart';
import 'package:flutter/material.dart';

import '../common/enum.dart';
import '../data/api/api_service.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService, required id}) {
    _getRestaurantById(id);
  }
  late DetailRestaurantModel _restResult;
  late ResultState _state;
  String _message = '';

  DetailRestaurantModel get restResult => _restResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _getRestaurantById(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getRestaurantById(id);
      if (result.toJson().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restResult = result;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
