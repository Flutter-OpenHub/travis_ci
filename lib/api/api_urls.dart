/*
 * api_urls.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

class ApiUrls {
  static const String baseUrl = "https://api.travis-ci.org";
  static const String userUrl = baseUrl + "/user";

  static const String reposUrl = baseUrl + "/repos";

  static const String repoUrl = baseUrl + "/repo/";

  static const String organizationsUrl = baseUrl + "/orgs";

  static const String myBuildsUrl = baseUrl + "/builds";

  static const String jobUrl = baseUrl + "/job/";
}
