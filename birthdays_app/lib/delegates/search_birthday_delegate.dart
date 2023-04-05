import 'package:flutter/material.dart';

class SearchBirthDayDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      const Text('buildActions'),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Text('buildLeading');
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('buildSuggestions');
  }
}
