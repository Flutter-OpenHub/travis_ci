// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors)).value;
  Computed<bool> _$hasApiErrorComputed;

  @override
  bool get hasApiError =>
      (_$hasApiErrorComputed ??= Computed<bool>(() => super.hasApiError)).value;

  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  User get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_UserStore.errorMessage');

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

  final _$syncAccountFutureAtom = Atom(name: '_UserStore.syncAccountFuture');

  @override
  ObservableFuture<User> get syncAccountFuture {
    _$syncAccountFutureAtom.context.enforceReadPolicy(_$syncAccountFutureAtom);
    _$syncAccountFutureAtom.reportObserved();
    return super.syncAccountFuture;
  }

  @override
  set syncAccountFuture(ObservableFuture<User> value) {
    _$syncAccountFutureAtom.context.conditionallyRunInAction(() {
      super.syncAccountFuture = value;
      _$syncAccountFutureAtom.reportChanged();
    }, _$syncAccountFutureAtom, name: '${_$syncAccountFutureAtom.name}_set');
  }

  final _$getUserFutureAtom = Atom(name: '_UserStore.getUserFuture');

  @override
  ObservableFuture<User> get getUserFuture {
    _$getUserFutureAtom.context.enforceReadPolicy(_$getUserFutureAtom);
    _$getUserFutureAtom.reportObserved();
    return super.getUserFuture;
  }

  @override
  set getUserFuture(ObservableFuture<User> value) {
    _$getUserFutureAtom.context.conditionallyRunInAction(() {
      super.getUserFuture = value;
      _$getUserFutureAtom.reportChanged();
    }, _$getUserFutureAtom, name: '${_$getUserFutureAtom.name}_set');
  }

  final _$syncAccountAsyncAction = AsyncAction('syncAccount');

  @override
  Future<dynamic> syncAccount(String token, CancelToken cancelToken) {
    return _$syncAccountAsyncAction
        .run(() => super.syncAccount(token, cancelToken));
  }

  final _$getUserAsyncAction = AsyncAction('getUser');

  @override
  Future<dynamic> getUser(String token, CancelToken cancelToken) {
    return _$getUserAsyncAction.run(() => super.getUser(token, cancelToken));
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void setUser(User value) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setUser(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }
}
