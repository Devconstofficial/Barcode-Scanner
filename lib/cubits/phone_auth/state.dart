part of 'cubit.dart';

class PhoneAuthState extends Equatable {
  final User? data;
  final String? message;

  const PhoneAuthState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

class PhoneAuthDefault extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {
  const PhoneAuthLoading() : super();
}

class PhoneAuthSuccess extends PhoneAuthState {
  const PhoneAuthSuccess({User? data}) : super();
}

class PhoneAuthFailed extends PhoneAuthState {
  const PhoneAuthFailed({String? message}) : super(message: message);
}

class OTPAuthLoading extends PhoneAuthState {
  const OTPAuthLoading() : super();
}

class OTPAuthSuccess extends PhoneAuthState {
  const OTPAuthSuccess({User? data}) : super(data: data);
}

class OTPAuthFailed extends PhoneAuthState {
  const OTPAuthFailed({String? message}) : super(message: message);
}
