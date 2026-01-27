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

// Hardcoded college rules
final Map<String, CollegeRules> collegeRules = {
  "LNMIIT": CollegeRules(accommodation: true, pronite: true, mess: false),
  "Anand international college of engineering ": CollegeRules(accommodation: false, pronite: true, mess: true),
  "Shri Agrasen snatkottar shiksha Mahavidyalaya": CollegeRules(accommodation: true, pronite: false, mess: true),
};
