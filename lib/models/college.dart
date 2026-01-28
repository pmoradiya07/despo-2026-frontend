class CollegeRules {
  final bool accommodation;
  final bool pronite;
  final bool mess;

  CollegeRules({
    this.accommodation = false,
    this.pronite = false,
    this.mess = false,
  });
}

final Map<String, CollegeRules> collegeRules = {
  "lnmiit": CollegeRules(accommodation: true, pronite: true, mess: false),
  "anand international college of engineering ": CollegeRules(accommodation: false, pronite: true, mess: true),
  "shri agrasen snatkottar shiksha mahavidyalaya": CollegeRules(accommodation: true, pronite: false, mess: true),
};
