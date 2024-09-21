import'package:flutter/material.dart';

AppBar commonAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      'Scheduler',
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Colors.white),
    ),
    actions: [
      IconButton(onPressed: (){}, icon: const Icon(Icons.horizontal_split_rounded))
    ],
  );
}