import 'package:dicoding_restaurants/common/constant.dart';
import 'package:dicoding_restaurants/data/api/api_service.dart';
import 'package:dicoding_restaurants/data/model/restaurant_model.dart';
import 'package:dicoding_restaurants/widgets/detail_restaurant.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant? restaurant;
  const CardRestaurant({Key? key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurant.routeName, arguments: restaurant!.id);
      },
      child: Container(
        width: size.width,
        height: 320,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 3),
              color: blackC.withOpacity(0.2),
            )
          ],
          color: whiteC,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
              child: Hero(
                tag: '${restaurant?.id}',
                child: Image.network(
                  '${ApiService.pictUrl}${restaurant?.pictureId}',
                  fit: BoxFit.cover,
                  width: size.width,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant?.name ?? 'Restaurant Names',
                          style: textStyle.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          restaurant?.description ?? 'Description',
                          style: textStyle.subtitle2?.copyWith(
                            color: greyC,
                          ),
                          maxLines: 2,
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
                              restaurant?.city ?? 'location',
                              style: textStyle.caption?.copyWith(color: greyC),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Chip(
                        backgroundColor: primary,
                        avatar: const Icon(
                          Icons.star_border_outlined,
                          color: onPrimary,
                          size: 18,
                        ),
                        label: Text(
                          restaurant?.rating.toString() ?? '0.0',
                          style: textStyle.bodyText2?.copyWith(color: onPrimary),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
