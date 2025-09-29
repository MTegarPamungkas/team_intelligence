import 'package:flutter/material.dart';
import 'package:team_intelligence/shared/widgets/cards/base_card.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;

  const UserCard({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: ListTile(title: Text(name), subtitle: Text(email)),
    );
  }
}
