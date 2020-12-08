// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restart_cancel_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RestartCancelBuildStore on _RestartCancelBuildStore, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_RestartCancelBuildStore.hasErrors'))
          .value;

  final _$dataAtom = Atom(name: '_RestartCancelBuildStore.data');

  @override
  Map<dynamic, dynamic> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(Map<dynamic, dynamic> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_RestartCancelBuildStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$restartCancelBuildFutureAtom =
      Atom(name: '_RestartCancelBuildStore.restartCancelBuildFuture');

  @override
  ObservableFuture<Map<dynamic, dynamic>> get restartCancelBuildFuture {
    _$restartCancelBuildFutureAtom.reportRead();
    return super.restartCancelBuildFuture;
  }

  @override
  set restartCancelBuildFuture(ObservableFuture<Map<dynamic, dynamic>> value) {
    _$restartCancelBuildFutureAtom
        .reportWrite(value, super.restartCancelBuildFuture, () {
      super.restartCancelBuildFuture = value;
    });
  }

  final _$restartCancelBuildAsyncAction =
      AsyncAction('_RestartCancelBuildStore.restartCancelBuild');

  @override
  Future<dynamic> restartCancelBuild(
      String id, bool isActivate, CancelToken cancelToken) {
    return _$restartCancelBuildAsyncAction
        .run(() => super.restartCancelBuild(id, isActivate, cancelToken));
  }

  @override
  String toString() {
    return '''
data: ${data},
errorMessage: ${errorMessage},
restartCancelBuildFuture: ${restartCancelBuildFuture},
hasErrors: ${hasErrors}
    ''';
  }
}
