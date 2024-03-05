/// Exception thrown when generating content fails.
///
/// The [message] may explain the cause of the failure
final class GroqException implements Exception {
  final String message;

  GroqException(this.message);

  @override
  String toString() => 'GenerativeAIException: $message';
}

/// Exception thrown when the user have a bad request
final class BadRequestError implements GroqException {
  @override
  final String message;

  BadRequestError(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when authentication fails
final class AuthenticationError implements GroqException {
  @override
  final String message;

  AuthenticationError(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when the user does not have permissions
final class PermissionDeniedError implements GroqException {
  @override
  final String message;

  PermissionDeniedError(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when the API is not found
final class NotFoundError implements GroqException {
  @override
  final String message;

  NotFoundError(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when entity is unprocessable
final class UnprocessableEntityError implements GroqException {
  @override
  final String message;

  UnprocessableEntityError(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when the user hit the limit
final class RateLimitError implements GroqException {
  @override
  final String message;

  RateLimitError(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when the server failed to generate content
final class InternalServerError implements GroqException {
  @override
  final String message;

  InternalServerError(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when the API failed
final class APIConnectionError implements GroqException {
  @override
  final String message;

  APIConnectionError(this.message);

  @override
  String toString() => message;
}

/// Parse error from server
GroqException parseErrorFor(int errorCode, Map<String, dynamic> jsonObject) {
  final errorMessage =
      (jsonObject['error'] as Map<String, dynamic>)['message'].toString();

  switch (errorCode) {
    case 400:
      return BadRequestError(errorMessage);
    case 401:
      return AuthenticationError(errorMessage);
    case 403:
      return PermissionDeniedError(errorMessage);
    case 404:
      return NotFoundError(errorMessage);
    case 422:
      return UnprocessableEntityError(errorMessage);
    case 429:
      return RateLimitError(errorMessage);
    case >= 500 && < 600:
      return InternalServerError(errorMessage);
    default:
      return APIConnectionError(errorMessage);
  }
}
