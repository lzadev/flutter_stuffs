import 'dart:math';
import 'package:intl/date_symbol_data_local.dart';

import 'package:birthdays_app/constants/colors.dart';
import 'package:birthdays_app/delegates/search_birthday_delegate.dart';
import 'package:birthdays_app/models/person.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final persons = Person.getAllPerson();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 60.0,
        title: const Text(
          'Cumpleaños',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBirthDayDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30.0,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 5.0,
                  color: primaryColor,
                );
              },
              physics: const BouncingScrollPhysics(),
              itemCount: persons.length,
              itemBuilder: ((context, index) {
                final person = persons[index];
                String dateOfBirthToDisplay = "";
                switch (person.birthDay.month) {
                  case 1:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Enero";
                    break;
                  case 2:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Febrero";
                    break;
                  case 3:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Marzo";
                    break;
                  case 4:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Abril";
                    break;
                  case 5:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Mayo";
                    break;
                  case 6:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Junio";
                    break;
                  case 7:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Julio";
                    break;
                  case 8:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Agosto";
                    break;
                  case 9:
                    dateOfBirthToDisplay =
                        "${person.birthDay.day} de Septiembre";
                    break;
                  case 10:
                    dateOfBirthToDisplay = "${person.birthDay.day} de Octubre";
                    break;
                  case 11:
                    dateOfBirthToDisplay =
                        "${person.birthDay.day} de Noviembre";
                    break;
                  case 12:
                    dateOfBirthToDisplay =
                        "${person.birthDay.day} de Diciembre";
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        "${person.name} ${person.lastName}",
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${person.department}/${person.position}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          dateOfBirthToDisplay,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                      child: Text(
                        "${person.name[0]}${person.lastName[0]}",
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline,
                        size: 20.0,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 15.0,
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
