/*
 * build_model.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import '../enum/build_status.dart';
import 'branch.dart';
import 'tag.dart';
import 'repository.dart';

class BuildsModel {
  final int id;
  final String number;
  final BuildState state;
  final int duration;
  final String previousState;
  final String updatedAt;
  final String createdAt;
  final CreatedBy createdBy;
  final Commit commit;
  final Repository repository;
  final Branch branch;
  final Tag tag;
  final List<Job> jobs;

  BuildsModel(
      {this.id,this.number,
      this.state,
      this.duration,
      this.previousState,
      this.createdBy,
      this.updatedAt,
      this.createdAt,
      this.commit,
      this.repository,
      this.branch,
      this.jobs,
      this.tag});

  factory BuildsModel.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> _jobs = parsedJson['jobs'];
    return BuildsModel(
      id: parsedJson['id'],
        state:
            enumFromString<BuildState>(BuildState.values, parsedJson['state']),
        number: parsedJson['number'],
        duration: parsedJson['duration'],
        updatedAt: parsedJson['updated_at'],
        createdAt: parsedJson['started_at'],
        repository: parsedJson['repository'] != null
            ? Repository.fromJson(parsedJson['repository'])
            : null,
        branch: parsedJson['branch'] != null
            ? Branch.fromJson(parsedJson['branch'])
            : null,
        tag: parsedJson['tag'] != null ? Tag.fromJson(parsedJson['tag']) : null,
        previousState: parsedJson['previous_state'],
        commit: Commit.fromJson(parsedJson['commit']),
        createdBy: CreatedBy.fromJson(parsedJson['created_by']),
        jobs:
            _jobs != null ? _jobs.map((e) => Job.fromJson(e)).toList() : null);
  }
}

class Commit {
  final int id;
  final String sha;
  final String ref;
  final String message;
  final String compareUrl;
  final String committedAt;

  Commit(
      {this.id,
      this.sha,
      this.ref,
      this.message,
      this.committedAt,
      this.compareUrl});

  factory Commit.fromJson(Map<String, dynamic> parsedJson) {
    return Commit(
        id: parsedJson['id'],
        sha: parsedJson['sha'],
        ref: parsedJson['ref'],
        message: parsedJson['message'],
        compareUrl: parsedJson['compare_url'],
        committedAt: parsedJson['committed_at']);
  }
}

class CreatedBy {
  final int id;
  final String login;
  final String type;
  final String href;

  CreatedBy({this.id, this.login, this.type, this.href});

  factory CreatedBy.fromJson(Map<String, dynamic> parsedJson) {
    return CreatedBy(
        id: parsedJson['id'],
        login: parsedJson['login'],
        href: parsedJson['@href'],
        type: parsedJson['@type']);
  }
}

class Job {
  final int id;
  final String type;
  final String href;

  Job({this.id, this.type, this.href});

  factory Job.fromJson(Map<String, dynamic> parsedJson) {
    return Job(
        id: parsedJson['id'],
        href: parsedJson['@href'],
        type: parsedJson['@type']);
  }
}
