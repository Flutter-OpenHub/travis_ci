// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStore, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_SettingsStore.hasErrors'))
          .value;

  final _$buildEmailsAtom = Atom(name: '_SettingsStore.buildEmails');

  @override
  bool get buildEmails {
    _$buildEmailsAtom.reportRead();
    return super.buildEmails;
  }

  @override
  set buildEmails(bool value) {
    _$buildEmailsAtom.reportWrite(value, super.buildEmails, () {
      super.buildEmails = value;
    });
  }

  final _$privateInsightsVisibilityAtom =
      Atom(name: '_SettingsStore.privateInsightsVisibility');

  @override
  String get privateInsightsVisibility {
    _$privateInsightsVisibilityAtom.reportRead();
    return super.privateInsightsVisibility;
  }

  @override
  set privateInsightsVisibility(String value) {
    _$privateInsightsVisibilityAtom
        .reportWrite(value, super.privateInsightsVisibility, () {
      super.privateInsightsVisibility = value;
    });
  }

  final _$buildEmailsResponseAtom =
      Atom(name: '_SettingsStore.buildEmailsResponse');

  @override
  BuildEmailsResponse? get buildEmailsResponse {
    _$buildEmailsResponseAtom.reportRead();
    return super.buildEmailsResponse;
  }

  @override
  set buildEmailsResponse(BuildEmailsResponse? value) {
    _$buildEmailsResponseAtom.reportWrite(value, super.buildEmailsResponse, () {
      super.buildEmailsResponse = value;
    });
  }

  final _$privateInsightsVisibilityResponseAtom =
      Atom(name: '_SettingsStore.privateInsightsVisibilityResponse');

  @override
  PrivateInsightsVisibilityResponse? get privateInsightsVisibilityResponse {
    _$privateInsightsVisibilityResponseAtom.reportRead();
    return super.privateInsightsVisibilityResponse;
  }

  @override
  set privateInsightsVisibilityResponse(
      PrivateInsightsVisibilityResponse? value) {
    _$privateInsightsVisibilityResponseAtom
        .reportWrite(value, super.privateInsightsVisibilityResponse, () {
      super.privateInsightsVisibilityResponse = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_SettingsStore.errorMessage');

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

  final _$updateSettingsFutureAtom =
      Atom(name: '_SettingsStore.updateSettingsFuture');

  @override
  ObservableFuture<BuildEmailsResponse>? get updateSettingsFuture {
    _$updateSettingsFutureAtom.reportRead();
    return super.updateSettingsFuture;
  }

  @override
  set updateSettingsFuture(ObservableFuture<BuildEmailsResponse>? value) {
    _$updateSettingsFutureAtom.reportWrite(value, super.updateSettingsFuture,
        () {
      super.updateSettingsFuture = value;
    });
  }

  final _$updatePrivateInsightsFutureAtom =
      Atom(name: '_SettingsStore.updatePrivateInsightsFuture');

  @override
  ObservableFuture<PrivateInsightsVisibilityResponse>?
      get updatePrivateInsightsFuture {
    _$updatePrivateInsightsFutureAtom.reportRead();
    return super.updatePrivateInsightsFuture;
  }

  @override
  set updatePrivateInsightsFuture(
      ObservableFuture<PrivateInsightsVisibilityResponse>? value) {
    _$updatePrivateInsightsFutureAtom
        .reportWrite(value, super.updatePrivateInsightsFuture, () {
      super.updatePrivateInsightsFuture = value;
    });
  }

  final _$getPreferencesFutureAtom =
      Atom(name: '_SettingsStore.getPreferencesFuture');

  @override
  ObservableFuture<List<dynamic>>? get getPreferencesFuture {
    _$getPreferencesFutureAtom.reportRead();
    return super.getPreferencesFuture;
  }

  @override
  set getPreferencesFuture(ObservableFuture<List<dynamic>>? value) {
    _$getPreferencesFutureAtom.reportWrite(value, super.getPreferencesFuture,
        () {
      super.getPreferencesFuture = value;
    });
  }

  final _$getPreferencesAsyncAction =
      AsyncAction('_SettingsStore.getPreferences');

  @override
  Future<dynamic> getPreferences(CancelToken cancelToken) {
    return _$getPreferencesAsyncAction
        .run(() => super.getPreferences(cancelToken));
  }

  final _$updateEmailSettingsAsyncAction =
      AsyncAction('_SettingsStore.updateEmailSettings');

  @override
  Future<dynamic> updateEmailSettings(bool value, CancelToken cancelToken) {
    return _$updateEmailSettingsAsyncAction
        .run(() => super.updateEmailSettings(value, cancelToken));
  }

  final _$updatePrivateInsightsVisibilityAsyncAction =
      AsyncAction('_SettingsStore.updatePrivateInsightsVisibility');

  @override
  Future<dynamic> updatePrivateInsightsVisibility(CancelToken cancelToken) {
    return _$updatePrivateInsightsVisibilityAsyncAction
        .run(() => super.updatePrivateInsightsVisibility(cancelToken));
  }

  @override
  String toString() {
    return '''
buildEmails: ${buildEmails},
privateInsightsVisibility: ${privateInsightsVisibility},
buildEmailsResponse: ${buildEmailsResponse},
privateInsightsVisibilityResponse: ${privateInsightsVisibilityResponse},
errorMessage: ${errorMessage},
updateSettingsFuture: ${updateSettingsFuture},
updatePrivateInsightsFuture: ${updatePrivateInsightsFuture},
getPreferencesFuture: ${getPreferencesFuture},
hasErrors: ${hasErrors}
    ''';
  }
}
