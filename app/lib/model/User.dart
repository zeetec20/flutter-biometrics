class User {
  final int id;
  final String name, email, token;
  final bool useBiometrics;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.useBiometrics,
      required this.token});
}
