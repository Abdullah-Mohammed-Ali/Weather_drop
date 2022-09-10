abstract class Exceptions {
  final String errorMessage;

  Exceptions(this.errorMessage);
}

class HttpException extends Exceptions {
  HttpException(super.errorMessage);
}
