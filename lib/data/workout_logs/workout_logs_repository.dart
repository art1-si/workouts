abstract interface class WorkoutLogsRepository<ReturnProtocolT> {
  ReturnProtocolT getWorkoutLogs({required String userId});
}
