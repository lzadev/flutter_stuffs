import 'package:birthdays_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final titletStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Container(
          color: primaryColor,
          child: Row(
            children: [
              // const Icon(
              //   Icons.cake_outlined,
              //   color: primaryColor,
              //   size: 35.0,
              // ),
              const SizedBox(
                width: 5.0,
              ),
              const Text(
                'Cumpleños',
                style: TextStyle(fontSize: 22.0),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: primaryColor,
                  size: 35.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
