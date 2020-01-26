// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError)).value;

  final _$tokenAtom = Atom(name: '_FormStore.token');

  @override
  String get token {
    _$tokenAtom.context.enforceReadPolicy(_$tokenAtom);
    _$tokenAtom.reportObserved();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.context.conditionallyRunInAction(() {
      super.token = value;
      _$tokenAtom.reportChanged();
    }, _$tokenAtom, name: '${_$tokenAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_FormStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$fetchReposFutureAtom = Atom(name: '_FormStore.fetchReposFuture');

  @override
  ObservableFuture<User> get authUserFuture {
    _$fetchReposFutureAtom.context.enforceReadPolicy(_$fetchReposFutureAtom);
    _$fetchReposFutureAtom.reportObserved();
    return super.authUserFuture;
  }

  @override
  set authUserFuture(ObservableFuture<User> value) {
    _$fetchReposFutureAtom.context.conditionallyRunInAction(() {
      super.authUserFuture = value;
      _$fetchReposFutureAtom.reportChanged();
    }, _$fetchReposFutureAtom, name: '${_$fetchReposFutureAtom.name}_set');
  }

  final _$authUserAsyncAction = AsyncAction('authUser');

  @override
  Future<dynamic> authUser() {
    return _$authUserAsyncAction.run(() => super.authUser());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void validateToken(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.validateToken(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }
}
