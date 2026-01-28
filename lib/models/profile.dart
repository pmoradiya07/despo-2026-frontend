class Profile {
  final String name;
  final String email;
  final String college;

  final bool mess;
  final bool accommodation;
  final bool pronite;

  Profile({
    required this.name,
    required this.email,
    required this.college,
    required this.mess,
    required this.accommodation,
    required this.pronite,
  });

  factory Profile.fromApi(Map<String, dynamic> json) {
    bool yesNoToBool(dynamic value) {
      return value.toString().toLowerCase() == 'yes';
    }

    return Profile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      college: json['college'] ?? '',
      mess: yesNoToBool(json['mess']),
      accommodation: yesNoToBool(json['accommodation']),
      pronite: yesNoToBool(json['pronite']),
    );
  }
}
