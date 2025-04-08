abstract class Failure implements Exception {
  Failure(this.message);
  final String message;

  @override
  String toString() => message;
}

class NoMessageFailure extends Failure {
  NoMessageFailure() : super("");
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}

class ServerErrorFailure extends Failure {
  ServerErrorFailure()
    : super('Terjadi kesalahan pada server, silahkan coba beberapa saat lagi');
}
