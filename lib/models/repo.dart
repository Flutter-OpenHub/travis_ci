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
  RepoPermissions permissions;

  RepositoriesModel(this.id, this.starred, this.active, this.name, this.slug,
      this.description, this.owner, this.permissions);

  factory RepositoriesModel.fromJson(Map<String, dynamic> parsedJson) {
    return RepositoriesModel(
      parsedJson['id'],
      parsedJson['starred'],
      parsedJson['active'],
      parsedJson['name'],
      parsedJson['slug'],
      parsedJson['description'],
      parsedJson['owner']['login'],
      RepoPermissions.fromJson(parsedJson['@permissions']),
    );
  }
}

class RepoPermissions {
  bool read;
  bool deleteKeyPair;
  bool createRequest;
  bool admin;
  bool activate;
  bool deactivate;
  bool migrate;
  bool star;
  bool createCron;
  bool unStar;
  bool createKeyPair;
  bool createEnvVar;

  RepoPermissions(
      {required this.read,
      required this.deleteKeyPair,
      required this.createRequest,
      required this.admin,
      required this.activate,
      required this.deactivate,
      required this.migrate,
      required this.star,
      required this.createCron,
      required this.unStar,
      required this.createKeyPair,
      required this.createEnvVar});

  factory RepoPermissions.fromJson(Map<String, dynamic> parsedJson) {
    return RepoPermissions(
      read: parsedJson['read'],
      star: parsedJson['star'],
      admin: parsedJson['admin'],
      unStar: parsedJson['unstar'],
      migrate: parsedJson['migrate'],
      activate: parsedJson['activate'],
      deactivate: parsedJson['deactivate'],
      createCron: parsedJson['create_cron'],
      createEnvVar: parsedJson['create_env_var'],
      createRequest: parsedJson['create_request'],
      createKeyPair: parsedJson['create_key_pair'],
      deleteKeyPair: parsedJson['delete_key_pair'],
    );
  }
}
