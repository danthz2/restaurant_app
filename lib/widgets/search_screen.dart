import 'package:dicoding_restaurants/widgets/card_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/enum.dart';
import '../data/api/api_service.dart';
import '../provider/search_restaurant_provider.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search_screen';
  final String query;
  const SearchScreen({Key? key, required this.query}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SearchRestaurantProvider>(
        create: (context) => SearchRestaurantProvider(apiService: ApiService(), query: query),
        child: Consumer<SearchRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return ListView(
                padding: const EdgeInsets.all(24).copyWith(top: 40),
                children: [
                  Text('Result Restaurants (${state.restResult.founded})'),
                  ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.restResult.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = state.restResult.restaurants[index];
                      return CardRestaurant(
                        restaurant: restaurant,
                      );
                    },
                  ),
                ],
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
