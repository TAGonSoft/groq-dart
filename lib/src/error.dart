final class GroqException implements Exception {
  final String message;

  GroqException(this.message);

  @override
  String toString() => 'GenerativeAIException: $message';
}

final class BadRequestError implements GroqException {
  @override
  final String message;

  BadRequestError(this.message);

  @override
  String toString() => message;
}

final class AuthenticationError implements GroqException {
  @override
  final String message;

  AuthenticationError(this.message);

  @override
  String toString() => message;
}

final class PermissionDeniedError implements GroqException {
  @override
  final String message;

  PermissionDeniedError(this.message);

  @override
  String toString() => message;
}

final class NotFoundError implements GroqException {
  @override
  final String message;

  NotFoundError(this.message);

  @override
  String toString() => message;
}

final class UnprocessableEntityError implements GroqException {
  @override
  final String message;

  UnprocessableEntityError(this.message);

  @override
  String toString() => message;
}

final class RateLimitError implements GroqException {
  @override
  final String message;

  RateLimitError(this.message);

  @override
  String toString() => message;
}

final class InternalServerError implements GroqException {
  @override
  final String message;

  InternalServerError(this.message);

  @override
  String toString() => message;
}

final class APIConnectionError implements GroqException {
  @override
  final String message;

  APIConnectionError(this.message);

  @override
  String toString() => message;
}

GroqException parseErrorFor(int errorCode, Map jsonObject) {
  String errorMessage = jsonObject['error']['message'];

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
