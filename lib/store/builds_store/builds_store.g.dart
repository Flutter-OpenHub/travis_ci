// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'builds_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BuildsStore on _BuildsStore, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors => (_$hasErrorsComputed ??=
          Computed<bool>(() => super.hasErrors, name: '_BuildsStore.hasErrors'))
      .value;

  final _$buildsAtom = Atom(name: '_BuildsStore.builds');

  @override
  ObservableList<BuildsModel> get builds {
    _$buildsAtom.reportRead();
    return super.builds;
  }

  @override
  set builds(ObservableList<BuildsModel> value) {
    _$buildsAtom.reportWrite(value, super.builds, () {
      super.builds = value;
    });
  }

  final _$buildLogAtom = Atom(name: '_BuildsStore.buildLog');

  @override
  String get buildLog {
    _$buildLogAtom.reportRead();
    return super.buildLog;
  }

  @override
  set buildLog(String value) {
    _$buildLogAtom.reportWrite(value, super.buildLog, () {
      super.buildLog = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_BuildsStore.errorMessage');

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

  final _$getBuildsFutureAtom = Atom(name: '_BuildsStore.getBuildsFuture');

  @override
  ObservableFuture<List<BuildsModel>> get getBuildsFuture {
    _$getBuildsFutureAtom.reportRead();
    return super.getBuildsFuture;
  }

  @override
  set getBuildsFuture(ObservableFuture<List<BuildsModel>> value) {
    _$getBuildsFutureAtom.reportWrite(value, super.getBuildsFuture, () {
      super.getBuildsFuture = value;
    });
  }

  final _$getBuildLogFutureAtom = Atom(name: '_BuildsStore.getBuildLogFuture');

  @override
  ObservableFuture<String> get getBuildLogFuture {
    _$getBuildLogFutureAtom.reportRead();
    return super.getBuildLogFuture;
  }

  @override
  set getBuildLogFuture(ObservableFuture<String> value) {
    _$getBuildLogFutureAtom.reportWrite(value, super.getBuildLogFuture, () {
      super.getBuildLogFuture = value;
    });
  }

  final _$getBuildsAsyncAction = AsyncAction('_BuildsStore.getBuilds');

  @override
  Future<dynamic> getBuilds(String id, CancelToken cancelToken) {
    return _$getBuildsAsyncAction.run(() => super.getBuilds(id, cancelToken));
  }

  final _$getBuildLogAsyncAction = AsyncAction('_BuildsStore.getBuildLog');

  @override
  Future<dynamic> getBuildLog(String id, CancelToken cancelToken) {
    return _$getBuildLogAsyncAction
        .run(() => super.getBuildLog(id, cancelToken));
  }

  @override
  String toString() {
    return '''
builds: ${builds},
buildLog: ${buildLog},
errorMessage: ${errorMessage},
getBuildsFuture: ${getBuildsFuture},
getBuildLogFuture: ${getBuildLogFuture},
hasErrors: ${hasErrors}
    ''';
  }
}
