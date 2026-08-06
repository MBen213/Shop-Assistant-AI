import 'package:flutter/material.dart';

class AboutTile extends StatelessWidget {
  const AboutTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(
          Icons.info_outline,
          color: Colors.green,
        ),
        title: Text(
          "About",
        ),
        subtitle: Text(
          "Shop Assistant AI\nVersion 1.0.0",
        ),
      ),
    );
  }
}