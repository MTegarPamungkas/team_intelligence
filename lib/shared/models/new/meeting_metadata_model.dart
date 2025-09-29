import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class MeetingMetadataModel extends Equatable implements BaseModel {
  final String? meetingTitle;
  final String? scheduledFor;
  final int? duration;
  final List<String>? attendees;

  const MeetingMetadataModel({
    this.meetingTitle,
    this.scheduledFor,
    this.duration,
    this.attendees,
  });

  factory MeetingMetadataModel.fromJson(Map<String, dynamic> json) {
    return MeetingMetadataModel(
      meetingTitle: json['meetingTitle'] as String? ?? '',
      scheduledFor: json['scheduledFor'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      attendees: (json['attendees'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'meetingTitle': meetingTitle,
    'scheduledFor': scheduledFor,
    'duration': duration,
    'attendees': attendees,
  };

  @override
  List<Object?> get props => [meetingTitle, scheduledFor, duration, attendees];
}
