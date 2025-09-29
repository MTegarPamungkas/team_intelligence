import 'package:flutter/material.dart';
import 'package:team_intelligence/shared/widgets/cards/base_card.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;

  const ProductCard({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: ListTile(
        title: Text(name),
        subtitle: Text('\$${price.toStringAsFixed(2)}'),
      ),
    );
  }
}
