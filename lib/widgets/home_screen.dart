import 'package:dicoding_restaurants/common/constant.dart';
import 'package:dicoding_restaurants/provider/restaurant_provider.dart';
import 'package:dicoding_restaurants/widgets/card_restaurant.dart';
import 'package:dicoding_restaurants/widgets/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/enum.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final queryC = TextEditingController();

  @override
  void dispose() {
    queryC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Cozy Restaurant',
              style: textStyle.headline5?.copyWith(fontWeight: FontWeight.bold, color: primary),
            ),
            Text(
              'Recommended comfortable place',
              style: textStyle.subtitle2?.copyWith(color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: queryC,
              style: textStyle.bodyText2?.copyWith(color: onSecondary),
              cursorColor: onSecondary,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: onSecondary),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: onSecondary),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchScreen.routeName, arguments: queryC.text);
                    queryC.text = '';
                  },
                  icon: const Icon(
                    Icons.search,
                    color: onSecondary,
                  ),
                ),
                hintText: 'Search  Restaurant',
                hintStyle: textStyle.bodyText2?.copyWith(
                  color: onSecondary,
                ),
              ),
            ),
            Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state.state == ResultState.hasData) {
                  return Column(
                    children: [
                      ListView.builder(
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
            )
          ],
        ),
      ),
    );
  }
}
