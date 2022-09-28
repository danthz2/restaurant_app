import 'package:dicoding_restaurants/common/constant.dart';
import 'package:dicoding_restaurants/data/model/detail_restaurant_model.dart';
import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final Category menu;
  const CardMenu({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: NetworkImage(
                'https://1.bp.blogspot.com/-qqe05eITwXI/Xo1yShz1haI/AAAAAAAAAZo/a7zt5AKV1D4-6XpJSvcZ_9VibyxUHEB2QCLcBGAsYHQ/s640/franchise%2Bminuman.jpg'),
            fit: BoxFit.cover,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(2),
            color: primary,
            child: Text(
              menu.name,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: onPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
