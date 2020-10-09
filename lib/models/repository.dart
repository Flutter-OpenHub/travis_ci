/*
 * repository.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

class Repository {
  final int id;
  final String name;
  final String slug;

  Repository(this.id, this.name, this.slug);

  factory Repository.fromJson(Map<String, dynamic> parsedJson) =>
      Repository(parsedJson['id'], parsedJson['name'], parsedJson['slug']);
}
