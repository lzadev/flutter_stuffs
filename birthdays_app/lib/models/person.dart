class Person {
  final String name;
  final String lastName;
  final String mail;
  final DateTime birthDay;
  final String department;
  final String position;

  Person(
      {required this.name,
      required this.lastName,
      required this.mail,
      required this.birthDay,
      required this.department,
      required this.position});

  static List<Person> getAllPerson() {
    List<Person> persons = [
      Person(
        name: "LUIS MANUEL",
        lastName: "SANTANA ALCANTARA",
        mail: "lsantana@mardom.com",
        birthDay: DateTime(1970, 11, 09),
        department: "TECNOLOGIA",
        position: "LIDER TECNICO SOPORTE DE APLICACIONES",
      ),
      Person(
        name: "EDGAR YAEL",
        lastName: "JIMENEZ GALVAN",
        mail: "ejimenez@mardom.com",
        birthDay: DateTime(1990, 10, 03),
        department: "TECNOLOGIA",
        position: "ARQUITECTO DE SOFTWARE",
      ),
      Person(
        name: "LGARINARDY",
        lastName: "RODRIGUEZ HERNANDEZ",
        mail: "grodriguez@reeferservices.com",
        birthDay: DateTime(1980, 03, 31),
        department: "TECNOLOGIA",
        position: "ENCARGADO/A DE SISTEMAS DE INFORMACION",
      ),
      Person(
        name: "YORDYS ARSENIO",
        lastName: "ARNAUD GARCIA",
        mail: "yarnaud@mardom.com",
        birthDay: DateTime(1991, 01, 21),
        department: "TECNOLOGIA",
        position: "DESARROLLADOR III",
      ),
      Person(
        name: "LUIS ALEJANDRO",
        lastName: "DEL ORDEN ZABALA",
        mail: "ldelorden@mardom.com",
        birthDay: DateTime(1995, 07, 10),
        department: "TECNOLOGIA",
        position: "DESARROLLADOR II",
      ),
    ];

    return persons;
  }
}
