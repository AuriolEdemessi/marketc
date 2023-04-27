
import '../../../export.dart';

class SignupState extends BaseState {
  SignupState({
    this.firstname = const TextFields.pure(),
    this.lastname = const TextFields.pure(),
    this.email = const Email.pure(),
    this.phonenumber = const TextFields.pure(),
    this.pseudo = const Pseudo.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.countryCode,
    this.message,
  });

  final TextFields firstname;
  final TextFields lastname;
  final Pseudo pseudo;
  final TextFields phonenumber;
  final CountryCode? countryCode;
  final Email email;
  final Password password;
  final FormzStatus status;
  final ErrorMessage? message;
  // final AuthState authState;
  //final Token? token;

  @override
  List<Object?> get props => [
    firstname,
    lastname,
    phonenumber,
    countryCode,
    pseudo,
    email,
    password,
    status,
    message,
   // token
  ];

  SignupState copyWith({
    TextFields? firstname,
    TextFields? lastname,
    Pseudo? pseudo,
    TextFields? phonenumber,
    CountryCode? countryCode,
    Email? email,
    Password? password,
    FormzStatus? status,
    ErrorMessage? message,
    //User? userModel,
    //AuthState? authState
    //Token? token,
  }) {
    return SignupState(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      pseudo: pseudo ?? this.pseudo,
      phonenumber: phonenumber ?? this.phonenumber,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
     // token: token ?? this.token,
      // authState: authState ?? this.authState,
      // currentUser: user ?? currentUser,
    );
  }
}