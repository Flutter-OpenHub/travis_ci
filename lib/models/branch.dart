/*
 * branch.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

class Branch {
  final String name;

  Branch(this.name);

  factory Branch.fromJson(Map<String, dynamic> parsedJson) =>
      Branch(parsedJson['name']);
}
