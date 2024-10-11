sealed class AsyncState<DataT> {
  const AsyncState();

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(DataT data) loaded,
    required R Function(Object error) error,
  }) {
    return switch (this) {
      Initial<DataT>() => initial(),
      Loading<DataT>() => loading(),
      Loaded<DataT>() => loaded((this as Loaded<DataT>).data),
      Error<DataT>() => error((this as Error<DataT>).error),
    };
  }

  R? maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(DataT data)? loaded,
    R Function(Object error)? error,
    R Function()? orElse,
  }) {
    return switch (this) {
      Initial<DataT>() => initial?.call() ?? orElse?.call(),
      Loading<DataT>() => loading?.call() ?? orElse?.call(),
      Loaded<DataT>() => loaded?.call((this as Loaded<DataT>).data) ?? orElse?.call(),
      Error<DataT>() => error?.call((this as Error<DataT>).error) ?? orElse?.call(),
    };
  }
}

class Initial<DataT> extends AsyncState<DataT> {
  const Initial();
}

class Loading<DataT> extends AsyncState<DataT> {
  const Loading();
}

class Loaded<DataT> extends AsyncState<DataT> {
  const Loaded(this.data);

  final DataT data;
}

class Error<DataT> extends AsyncState<DataT> {
  const Error(this.error);

  final Object error;
}
