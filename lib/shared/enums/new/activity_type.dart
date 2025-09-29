enum ActivityType {
  commit, // Code commit pushed
  taskStarted, // Task work started
  taskCompleted, // Task completed
  taskAssigned, // Task assigned to member
  statusUpdate, // Task status updated
  progressUpdate, // Task progress updated
  commentAdded, // Comment added
  meetingScheduled, // Meeting scheduled
  focusStarted, // Focus session started
  focusEnded, // Focus session ended
  fileUploaded, // File uploaded
  memberJoined, // Member joined project
  memberLeft, // Member left project
}
