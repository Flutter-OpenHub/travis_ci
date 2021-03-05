/*
 * private_insights_visibility.dart
 *
 * Created by Amit Khairnar on 13/10/2020.
 */

class PrivateInsightsVisibilityResponse {
  final String name;
  final String value;

  PrivateInsightsVisibilityResponse({required this.name, required this.value});

  factory PrivateInsightsVisibilityResponse.fromJson(
          Map<String, dynamic> parsedJson) =>
      PrivateInsightsVisibilityResponse(
          name: parsedJson['name'], value: parsedJson['value']);
}
