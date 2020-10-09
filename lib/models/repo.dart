/*
 * repo.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

class PageModel {
  int limit;
  int offset;

  PageModel(this.limit, this.offset);

  PageModel.fromJson(Map<String, dynamic> json)
      : limit = json['limit'],
        offset = json['offset'];
}

class Pagination {
  var first;
  var next;
  var prev;
  var last;

  int limit;
  int count;
  int offset;
  bool isFirst;
  bool isLast;

  Pagination(this.first, this.next, this.prev, this.last, this.limit,
      this.count, this.offset, this.isFirst, this.isLast);

  Pagination.fromJson(Map<String, dynamic> json)
      : first = json['first'],
        next = json['next'],
        prev = json['prev'],
        last = json['last'],
        limit = json['limit'],
        count = json['count'],
        offset = json['offset'],
        isFirst = json['is_first'],
        isLast = json['is_last'];
}

class PaginationModel {
  var pages;

  PaginationModel(this.pages);

  PaginationModel.fromJson(Map<String, dynamic> json)
      : pages = json['@pagination'];
}

class Repositories {
  final List<RepositoriesModel> repos;

  Repositories(this.repos);

  static List<RepositoriesModel> getListFromJson(List<dynamic> parsedJson) {
    return parsedJson.map((i) => RepositoriesModel.fromJson(i)).toList();
  }
}

class RepositoriesModel {
  int id;
  bool starred;
  bool active;
  String name;
  String slug;
  String owner;
  String description;

  RepositoriesModel(this.id, this.starred, this.active, this.name, this.slug,
      this.description, this.owner);

  factory RepositoriesModel.fromJson(Map<String, dynamic> parsedJson) {
    return RepositoriesModel(
        parsedJson['id'],
        parsedJson['starred'],
        parsedJson['active'],
        parsedJson['name'],
        parsedJson['slug'],
        parsedJson['description'],
        parsedJson['owner']['login']);
  }
}
