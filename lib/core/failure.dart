abstract class Failure {
  String message;

  Failure(String msg) : message = msg;
}

class OtherFailure extends Failure {
  OtherFailure(super.message);
}
