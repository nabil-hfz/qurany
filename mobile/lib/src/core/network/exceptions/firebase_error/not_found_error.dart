import 'package:kawtharuna/src/core/network/exceptions/firebase_error/base_error.dart';

class NotFoundError extends BaseError {
  final String? message;

  const NotFoundError([this.message]);

  @override
  List<Object?> get props => [message];
}
