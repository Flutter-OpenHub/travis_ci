/*
 * build_status.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

enum BuildState { passed, failed, canceled, started, errored }

T enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value,
      orElse: () => null);
}
