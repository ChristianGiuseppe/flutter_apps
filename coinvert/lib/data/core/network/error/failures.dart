import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ServerFailure extends Failure {
  final String error;

  const ServerFailure(this.error) : super(error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $error}';
  }
}

class ConnectionFailure extends Failure {
  final String error;

  const ConnectionFailure(this.error) : super(error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $error}';
  }
}
