abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'An unexpected server error occurred.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache failure.']);
}

class AuthFailure extends Failure {
  final String code;
  const AuthFailure(this.code, [super.message = 'Authentication failed.']);

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const AuthFailure(
            'invalid-credential', 'Incorrect email or password.');
      case 'invalid-email':
        return const AuthFailure(
            'invalid-email', 'The email address is invalid.');
      case 'user-disabled':
        return const AuthFailure(
            'user-disabled', 'This account has been disabled.');
      case 'email-already-in-use':
        return const AuthFailure('email-already-in-use',
            'An account already exists for this email.');
      case 'weak-password':
        return const AuthFailure('weak-password', 'The password is too weak.');
      case 'network-request-failed':
        return const AuthFailure(
            'network-error', 'Network error. Please check your connection.');
      case 'too-many-requests':
        return const AuthFailure(
            'too-many-requests', 'Too many attempts. Please try again later.');
      default:
        return AuthFailure(
            code, 'Authentication failed ($code). Please try again.');
    }
  }
}
