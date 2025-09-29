abstract class InsightEvent {}

class FetchInsight extends InsightEvent {}

class ProjectChanged extends InsightEvent {
  final String projectId;

  ProjectChanged(this.projectId);
}
