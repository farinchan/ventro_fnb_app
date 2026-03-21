import 'package:flutter/material.dart';

class PlaceholderContentPage extends StatelessWidget {
  final String title;

  const PlaceholderContentPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
