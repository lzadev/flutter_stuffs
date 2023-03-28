import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider_app/models/bread_crumb.dart';

class BreadCrumbsWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumbs;
  const BreadCrumbsWidget({super.key, required this.breadCrumbs});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map((breadCrumb) {
        return GestureDetector(
          onTap: () {},
          child: Text(
            breadCrumb.title,
            style: TextStyle(
              color: breadCrumb.isActive ? Colors.indigo : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }
}
