abstract base class UseCase<ResultT> {
  const UseCase();

  /// Executes the use case.
  Future<ResultT> execute();
}
