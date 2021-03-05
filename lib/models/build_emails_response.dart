/*
 * build_emails_response.dart
 *
 * Created by Amit Khairnar on 13/10/2020.
 */

class BuildEmailsResponse {
  final String name;
  final bool value;

  BuildEmailsResponse({required this.name, required this.value});

  factory BuildEmailsResponse.fromJson(Map<String, dynamic> parsedJson) =>
      BuildEmailsResponse(name: parsedJson['name'], value: parsedJson['value']);
}
