/*
 * token_store.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:mobx/mobx.dart';

part 'token_store.g.dart';

class TokenStore = _TokenStore with _$TokenStore;

abstract class _TokenStore with Store {
  @observable
  String token;

  @computed
  String get authorizationToken => "token $token";
}
