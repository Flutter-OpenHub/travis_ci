/*
 * user.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

class User {
  int id;
  bool isSyncing;
  String name;
  String login;
  String avatarUrl;
  String lastSynced;

  User(this.id, this.isSyncing, this.name, this.login, this.avatarUrl);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        isSyncing = json['is_syncing'],
        lastSynced = json['synced_at'],
        login = json['login'],
        avatarUrl = json['avatar_url'];
}
