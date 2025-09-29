abstract class DashboardEvent {}

class FetchDashboard extends DashboardEvent {}

class ProjectChanged extends DashboardEvent {
  final String projectId;

  ProjectChanged(this.projectId);
}
