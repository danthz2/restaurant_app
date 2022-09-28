import 'package:dicoding_restaurants/data/api/api_service.dart';
import 'package:dicoding_restaurants/provider/detail_restaurant_provider.dart';

import 'package:dicoding_restaurants/widgets/card_menu.dart';
import 'package:dicoding_restaurants/widgets/review.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constant.dart';
import '../common/enum.dart';

class DetailRestaurant extends StatelessWidget {
  static const routeName = '/detail_restaurant';

  final String? restaurantId;
  const DetailRestaurant({Key? key, this.restaurantId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (context) => DetailRestaurantProvider(
        apiService: ApiService(),
        id: restaurantId,
      ),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.restResult;
              return Scaffold(
                body: ListView(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: restaurant.id,
                          child: Image.network('${ApiService.pictUrl}${restaurant.pictureId}'),
                        ),
                        Positioned(
                          bottom: 30,
                          right: 30,
                          child: Chip(
                            backgroundColor: primary,
                            avatar: const Icon(
                              Icons.star_border_outlined,
                              color: onPrimary,
                              size: 18,
                            ),
                            label: Text(
                              restaurant.rating.toString(),
                              style: textStyle.bodyText2?.copyWith(color: onPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: textStyle.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                size: 16,
                                color: greyC,
                              ),
                              Text(
                                restaurant.city,
                                style: textStyle.caption?.copyWith(color: greyC),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: restaurant.categories
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Chip(
                                      backgroundColor: secondary,
                                      label: Text(e.name),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'About us',
                            style: textStyle.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            restaurant.description,
                            style: textStyle.subtitle2?.copyWith(
                              color: greyC,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Food Packet',
                        style: textStyle.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menus.foods.length,
                        itemBuilder: (context, index) {
                          return CardMenu(
                            menu: restaurant.menus.foods[index],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Drink Packet',
                        style: textStyle.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menus.drinks.length,
                        itemBuilder: (context, index) {
                          return CardMenu(
                            menu: restaurant.menus.drinks[index],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reviews',
                            style: textStyle.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                              children: restaurant.customerReviews
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Review(
                                          review: e,
                                        ),
                                      ))
                                  .toList()),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: textStyle.headline5?.copyWith(
                              color: greyC,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$ 100',
                            style: textStyle.headline5?.copyWith(
                              color: onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, 40),
                          textStyle: textStyle.headline6,
                        ),
                        child: const Text('Booking Now'),
                      ),
                    ],
                  ),
                ),
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
