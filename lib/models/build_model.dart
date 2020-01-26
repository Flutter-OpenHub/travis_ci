class BuildsModel {
  final String number;
  final String state;
  final int duration;
  final String previousState;
  final Map<String, dynamic> createdBy;
  final Map<String, dynamic> commit;
  final Map<String, dynamic> repository;

  BuildsModel(this.number, this.state, this.duration, this.previousState,
      this.createdBy, this.commit, this.repository);
}
