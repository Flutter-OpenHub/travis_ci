/*
 * tag.dart
 *
 * Created by Amit Khairnar on 11/10/2020.
 */

class Tag {
  final String name;

  Tag(this.name);

  factory Tag.fromJson(Map<String, dynamic> parsedJson) =>
      Tag(parsedJson['name']);
}
