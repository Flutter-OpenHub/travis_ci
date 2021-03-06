/*
 * form_error_store.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:mobx/mobx.dart';

part 'form_error_store.g.dart';

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String token;

  @computed
  bool get hasErrors => token != null;
}
