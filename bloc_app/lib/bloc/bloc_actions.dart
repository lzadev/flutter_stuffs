import 'package:bloc_app/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const persons1Url = "http://10.228.35.92:5500/api/persons1.json";
const persons2Url = "http://10.228.35.92:5500/api/persons2.json";
// enum PersonUrl { person1, person2 }

// extension UrlString on PersonUrl {
//   String get urlString {
//     switch (this) {
//       case PersonUrl.person1:
//         return "http://10.228.43.61:5500/api/persons1.json";
//       case PersonUrl.person2:
//         return "http://10.228.43.61:5500/api/persons2.json";
//     }
//   }
// }

typedef PersonLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction extends LoadAction {
  final String url;
  final PersonLoader loader;
  const LoadPersonsAction({required this.url, required this.loader});
}
