import 'dart:convert';

class CvModel {
  ContactInformation? contactInformation;
  ProfessionalSummary? professionalSummary;
  List<WorkExperience>? workExperience;
  List<Education>? education;
  Skills? skills;

  CvModel({
    this.contactInformation,
    this.professionalSummary,
    this.workExperience,
    this.education,
    this.skills,
  });

  CvModel copyWith({
    ContactInformation? contactInformation,
    ProfessionalSummary? professionalSummary,
    List<WorkExperience>? workExperience,
    List<Education>? education,
    Skills? skills,
  }) =>
      CvModel(
        contactInformation: contactInformation ?? this.contactInformation,
        professionalSummary: professionalSummary ?? this.professionalSummary,
        workExperience: workExperience ?? this.workExperience,
        education: education ?? this.education,
        skills: skills ?? this.skills,
      );

  factory CvModel.fromJson(String str) => CvModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CvModel.fromMap(Map<String, dynamic> json) => CvModel(
    contactInformation: json["contactInformation"] == null ? null : ContactInformation.fromMap(json["contactInformation"]),
    professionalSummary: json["professionalSummary"] == null ? null : ProfessionalSummary.fromMap(json["professionalSummary"]),
    workExperience: json["workExperience"] == null ? [] : List<WorkExperience>.from(json["workExperience"]!.map((x) => WorkExperience.fromMap(x))),
    education: json["education"] == null ? [] : List<Education>.from(json["education"]!.map((x) => Education.fromMap(x))),
    skills: json["skills"] == null ? null : Skills.fromMap(json["skills"]),
  );

  Map<String, dynamic> toMap() => {
    "contactInformation": contactInformation?.toMap(),
    "professionalSummary": professionalSummary?.toMap(),
    "workExperience": workExperience == null ? [] : List<dynamic>.from(workExperience!.map((x) => x.toMap())),
    "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x.toMap())),
    "skills": skills?.toMap(),
  };
}

class ContactInformation {
  ProfessionalSummary? fullName;
  ProfessionalSummary? phoneNumber;
  ProfessionalSummary? email;
  ProfessionalSummary? linkedin;
  ProfessionalSummary? address;

  ContactInformation({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.linkedin,
    this.address,
  });

  ContactInformation copyWith({
    ProfessionalSummary? fullName,
    ProfessionalSummary? phoneNumber,
    ProfessionalSummary? email,
    ProfessionalSummary? linkedin,
    ProfessionalSummary? address,
  }) =>
      ContactInformation(
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        linkedin: linkedin ?? this.linkedin,
        address: address ?? this.address,
      );

  factory ContactInformation.fromJson(String str) => ContactInformation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactInformation.fromMap(Map<String, dynamic> json) => ContactInformation(
    fullName: json["fullName"] == null ? null : ProfessionalSummary.fromMap(json["fullName"]),
    phoneNumber: json["phoneNumber"] == null ? null : ProfessionalSummary.fromMap(json["phoneNumber"]),
    email: json["email"] == null ? null : ProfessionalSummary.fromMap(json["email"]),
    linkedin: json["linkedin"] == null ? null : ProfessionalSummary.fromMap(json["linkedin"]),
    address: json["address"] == null ? null : ProfessionalSummary.fromMap(json["address"]),
  );

  Map<String, dynamic> toMap() => {
    "fullName": fullName?.toMap(),
    "phoneNumber": phoneNumber?.toMap(),
    "email": email?.toMap(),
    "linkedin": linkedin?.toMap(),
    "address": address?.toMap(),
  };
}

class ProfessionalSummary {
  String? value;
  IsBold? isBold;
  Color? color;
  int? font;
  int? componentPlaceInX;
  int? componentPlaceInY;
  int? componentHeight;
  int? componentWidth;

  ProfessionalSummary({
    this.value,
    this.isBold,
    this.color,
    this.font,
    this.componentPlaceInX,
    this.componentPlaceInY,
    this.componentHeight,
    this.componentWidth,
  });

  ProfessionalSummary copyWith({
    String? value,
    IsBold? isBold,
    Color? color,
    int? font,
    int? componentPlaceInX,
    int? componentPlaceInY,
    int? componentHeight,
    int? componentWidth,
  }) =>
      ProfessionalSummary(
        value: value ?? this.value,
        isBold: isBold ?? this.isBold,
        color: color ?? this.color,
        font: font ?? this.font,
        componentPlaceInX: componentPlaceInX ?? this.componentPlaceInX,
        componentPlaceInY: componentPlaceInY ?? this.componentPlaceInY,
        componentHeight: componentHeight ?? this.componentHeight,
        componentWidth: componentWidth ?? this.componentWidth,
      );

  factory ProfessionalSummary.fromJson(String str) => ProfessionalSummary.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfessionalSummary.fromMap(Map<String, dynamic> json) => ProfessionalSummary(
    value: json["value"],
    isBold: isBoldValues.map[json["isBold"]]!,
    color: colorValues.map[json["color"]]!,
    font: json["font"],
    componentPlaceInX: json["componentPlaceInX"],
    componentPlaceInY: json["componentPlaceInY"],
    componentHeight: json["componentHeight"],
    componentWidth: json["componentWidth"],
  );

  Map<String, dynamic> toMap() => {
    "value": value,
    "isBold": isBoldValues.reverse[isBold],
    "color": colorValues.reverse[color],
    "font": font,
    "componentPlaceInX": componentPlaceInX,
    "componentPlaceInY": componentPlaceInY,
    "componentHeight": componentHeight,
    "componentWidth": componentWidth,
  };
}

enum Color {
  THE_000000,
  THE_0000_FF,
  THE_333333,
  THE_555555
}

final colorValues = EnumValues({
  "#000000": Color.THE_000000,
  "#0000FF": Color.THE_0000_FF,
  "#333333": Color.THE_333333,
  "#555555": Color.THE_555555
});

enum IsBold {
  NO,
  YES
}

final isBoldValues = EnumValues({
  "no": IsBold.NO,
  "yes": IsBold.YES
});

class Education {
  ProfessionalSummary? degree;
  ProfessionalSummary? institution;
  ProfessionalSummary? location;
  ProfessionalSummary? graduationDate;

  Education({
    this.degree,
    this.institution,
    this.location,
    this.graduationDate,
  });

  Education copyWith({
    ProfessionalSummary? degree,
    ProfessionalSummary? institution,
    ProfessionalSummary? location,
    ProfessionalSummary? graduationDate,
  }) =>
      Education(
        degree: degree ?? this.degree,
        institution: institution ?? this.institution,
        location: location ?? this.location,
        graduationDate: graduationDate ?? this.graduationDate,
      );

  factory Education.fromJson(String str) => Education.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Education.fromMap(Map<String, dynamic> json) => Education(
    degree: json["degree"] == null ? null : ProfessionalSummary.fromMap(json["degree"]),
    institution: json["institution"] == null ? null : ProfessionalSummary.fromMap(json["institution"]),
    location: json["location"] == null ? null : ProfessionalSummary.fromMap(json["location"]),
    graduationDate: json["graduationDate"] == null ? null : ProfessionalSummary.fromMap(json["graduationDate"]),
  );

  Map<String, dynamic> toMap() => {
    "degree": degree?.toMap(),
    "institution": institution?.toMap(),
    "location": location?.toMap(),
    "graduationDate": graduationDate?.toMap(),
  };
}

class Skills {
  List<ProfessionalSummary>? technicalSkills;
  List<ProfessionalSummary>? interpersonalSkills;

  Skills({
    this.technicalSkills,
    this.interpersonalSkills,
  });

  Skills copyWith({
    List<ProfessionalSummary>? technicalSkills,
    List<ProfessionalSummary>? interpersonalSkills,
  }) =>
      Skills(
        technicalSkills: technicalSkills ?? this.technicalSkills,
        interpersonalSkills: interpersonalSkills ?? this.interpersonalSkills,
      );

  factory Skills.fromJson(String str) => Skills.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Skills.fromMap(Map<String, dynamic> json) => Skills(
    technicalSkills: json["technicalSkills"] == null ? [] : List<ProfessionalSummary>.from(json["technicalSkills"]!.map((x) => ProfessionalSummary.fromMap(x))),
    interpersonalSkills: json["interpersonalSkills"] == null ? [] : List<ProfessionalSummary>.from(json["interpersonalSkills"]!.map((x) => ProfessionalSummary.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "technicalSkills": technicalSkills == null ? [] : List<dynamic>.from(technicalSkills!.map((x) => x.toMap())),
    "interpersonalSkills": interpersonalSkills == null ? [] : List<dynamic>.from(interpersonalSkills!.map((x) => x.toMap())),
  };
}

class WorkExperience {
  ProfessionalSummary? jobTitle;
  ProfessionalSummary? company;
  ProfessionalSummary? location;
  EmploymentDates? employmentDates;
  List<ProfessionalSummary>? responsibilities;

  WorkExperience({
    this.jobTitle,
    this.company,
    this.location,
    this.employmentDates,
    this.responsibilities,
  });

  WorkExperience copyWith({
    ProfessionalSummary? jobTitle,
    ProfessionalSummary? company,
    ProfessionalSummary? location,
    EmploymentDates? employmentDates,
    List<ProfessionalSummary>? responsibilities,
  }) =>
      WorkExperience(
        jobTitle: jobTitle ?? this.jobTitle,
        company: company ?? this.company,
        location: location ?? this.location,
        employmentDates: employmentDates ?? this.employmentDates,
        responsibilities: responsibilities ?? this.responsibilities,
      );

  factory WorkExperience.fromJson(String str) => WorkExperience.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkExperience.fromMap(Map<String, dynamic> json) => WorkExperience(
    jobTitle: json["jobTitle"] == null ? null : ProfessionalSummary.fromMap(json["jobTitle"]),
    company: json["company"] == null ? null : ProfessionalSummary.fromMap(json["company"]),
    location: json["location"] == null ? null : ProfessionalSummary.fromMap(json["location"]),
    employmentDates: json["employmentDates"] == null ? null : EmploymentDates.fromMap(json["employmentDates"]),
    responsibilities: json["responsibilities"] == null ? [] : List<ProfessionalSummary>.from(json["responsibilities"]!.map((x) => ProfessionalSummary.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "jobTitle": jobTitle?.toMap(),
    "company": company?.toMap(),
    "location": location?.toMap(),
    "employmentDates": employmentDates?.toMap(),
    "responsibilities": responsibilities == null ? [] : List<dynamic>.from(responsibilities!.map((x) => x.toMap())),
  };
}

class EmploymentDates {
  ProfessionalSummary? start;
  ProfessionalSummary? end;

  EmploymentDates({
    this.start,
    this.end,
  });

  EmploymentDates copyWith({
    ProfessionalSummary? start,
    ProfessionalSummary? end,
  }) =>
      EmploymentDates(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  factory EmploymentDates.fromJson(String str) => EmploymentDates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmploymentDates.fromMap(Map<String, dynamic> json) => EmploymentDates(
    start: json["start"] == null ? null : ProfessionalSummary.fromMap(json["start"]),
    end: json["end"] == null ? null : ProfessionalSummary.fromMap(json["end"]),
  );

  Map<String, dynamic> toMap() => {
    "start": start?.toMap(),
    "end": end?.toMap(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
