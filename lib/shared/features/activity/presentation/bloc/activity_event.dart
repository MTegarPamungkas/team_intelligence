abstract class ActivityEvent {}

class FetchActivity extends ActivityEvent {}

class ProjectChanged extends ActivityEvent {
  final String projectId;

  ProjectChanged(this.projectId);
}
