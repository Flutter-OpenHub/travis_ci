// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_listtile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RepoListTileStore on _RepoListTileStore, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_RepoListTileStore.hasErrors'))
          .value;

  final _$repositoriesModelAtom =
      Atom(name: '_RepoListTileStore.repositoriesModel');

  @override
  RepositoriesModel? get repositoriesModel {
    _$repositoriesModelAtom.reportRead();
    return super.repositoriesModel;
  }

  @override
  set repositoriesModel(RepositoriesModel? value) {
    _$repositoriesModelAtom.reportWrite(value, super.repositoriesModel, () {
      super.repositoriesModel = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_RepoListTileStore.errorMessage');

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

  final _$activateDeactivateRepoFutureAtom =
      Atom(name: '_RepoListTileStore.activateDeactivateRepoFuture');

  @override
  ObservableFuture<RepositoriesModel>? get activateDeactivateRepoFuture {
    _$activateDeactivateRepoFutureAtom.reportRead();
    return super.activateDeactivateRepoFuture;
  }

  @override
  set activateDeactivateRepoFuture(ObservableFuture<RepositoriesModel>? value) {
    _$activateDeactivateRepoFutureAtom
        .reportWrite(value, super.activateDeactivateRepoFuture, () {
      super.activateDeactivateRepoFuture = value;
    });
  }

  final _$activateDeactivateRepoAsyncAction =
      AsyncAction('_RepoListTileStore.activateDeactivateRepo');

  @override
  Future<dynamic> activateDeactivateRepo(
      String id, bool isActivate, CancelToken cancelToken) {
    return _$activateDeactivateRepoAsyncAction
        .run(() => super.activateDeactivateRepo(id, isActivate, cancelToken));
  }

  @override
  String toString() {
    return '''
repositoriesModel: ${repositoriesModel},
errorMessage: ${errorMessage},
activateDeactivateRepoFuture: ${activateDeactivateRepoFuture},
hasErrors: ${hasErrors}
    ''';
  }
}
