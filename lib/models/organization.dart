class Organization {
  String name;
  String login;
  String avatarUrl;

  //TODO Add repositories

  Organization(this.name, this.login, this.avatarUrl);

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(json['name'], json['login'], json['avatar_url']);
  }
}

class Organizations {
  final List<Organization> organizations;

  Organizations(this.organizations);

  static List<Organization> getListFromJson(List<dynamic> parsedJson) {
    return parsedJson.map((i) => Organization.fromJson(i)).toList();
  }
}
