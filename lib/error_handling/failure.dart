abstract class Failures {
  final String error;

  Failures(this.error);
}

class HttpFailures extends Failures {
  HttpFailures(super.error);
}
