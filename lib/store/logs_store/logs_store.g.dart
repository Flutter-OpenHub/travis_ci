// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LogsStore on _LogsStore, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors => (_$hasErrorsComputed ??=
          Computed<bool>(() => super.hasErrors, name: '_LogsStore.hasErrors'))
      .value;

  final _$buildLogAtom = Atom(name: '_LogsStore.buildLog');

  @override
  Map<dynamic, dynamic>? get buildLog {
    _$buildLogAtom.reportRead();
    return super.buildLog;
  }

  @override
  set buildLog(Map<dynamic, dynamic>? value) {
    _$buildLogAtom.reportWrite(value, super.buildLog, () {
      super.buildLog = value;
    });
  }

  final _$buildLogTxtAtom = Atom(name: '_LogsStore.buildLogTxt');

  @override
  String? get buildLogTxt {
    _$buildLogTxtAtom.reportRead();
    return super.buildLogTxt;
  }

  @override
  set buildLogTxt(String? value) {
    _$buildLogTxtAtom.reportWrite(value, super.buildLogTxt, () {
      super.buildLogTxt = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_LogsStore.errorMessage');

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

  final _$getBuildLogFutureAtom = Atom(name: '_LogsStore.getBuildLogFuture');

  @override
  ObservableFuture<Map<dynamic, dynamic>>? get getBuildLogFuture {
    _$getBuildLogFutureAtom.reportRead();
    return super.getBuildLogFuture;
  }

  @override
  set getBuildLogFuture(ObservableFuture<Map<dynamic, dynamic>>? value) {
    _$getBuildLogFutureAtom.reportWrite(value, super.getBuildLogFuture, () {
      super.getBuildLogFuture = value;
    });
  }

  final _$getBuildLogTxtFutureAtom =
      Atom(name: '_LogsStore.getBuildLogTxtFuture');

  @override
  ObservableFuture<String>? get getBuildLogTxtFuture {
    _$getBuildLogTxtFutureAtom.reportRead();
    return super.getBuildLogTxtFuture;
  }

  @override
  set getBuildLogTxtFuture(ObservableFuture<String>? value) {
    _$getBuildLogTxtFutureAtom.reportWrite(value, super.getBuildLogTxtFuture,
        () {
      super.getBuildLogTxtFuture = value;
    });
  }

  final _$getBuildLogAsyncAction = AsyncAction('_LogsStore.getBuildLog');

  @override
  Future<dynamic> getBuildLog(String id, CancelToken cancelToken) {
    return _$getBuildLogAsyncAction
        .run(() => super.getBuildLog(id, cancelToken));
  }

  final _$getBuildLogTxtAsyncAction = AsyncAction('_LogsStore.getBuildLogTxt');

  @override
  Future<dynamic> getBuildLogTxt(String id, CancelToken cancelToken) {
    return _$getBuildLogTxtAsyncAction
        .run(() => super.getBuildLogTxt(id, cancelToken));
  }

  @override
  String toString() {
    return '''
buildLog: ${buildLog},
buildLogTxt: ${buildLogTxt},
errorMessage: ${errorMessage},
getBuildLogFuture: ${getBuildLogFuture},
getBuildLogTxtFuture: ${getBuildLogTxtFuture},
hasErrors: ${hasErrors}
    ''';
  }
}
