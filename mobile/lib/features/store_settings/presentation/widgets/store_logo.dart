import 'package:flutter/material.dart';

class StoreLogo extends StatelessWidget {
  final String? logoPath;
  final VoidCallback onTap;

  const StoreLogo({
    super.key,
    required this.logoPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(80),
        onTap: onTap,
        child: CircleAvatar(
          radius: 55,
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          backgroundImage: logoPath != null
              ? AssetImage(logoPath!)
              : null,
          child: logoPath == null
              ? const Icon(
                  Icons.store,
                  size: 50,
                )
              : null,
        ),
      ),
    );
  }
}