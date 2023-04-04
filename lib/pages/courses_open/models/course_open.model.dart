import 'dart:convert';

CourseOpen courseOpenFromJson(String str) =>
    CourseOpen.fromJson(json.decode(str));

String courseOpenToJson(CourseOpen data) => json.encode(data.toJson());

class CourseOpen {
  CourseOpen({
    required this.id,
    required this.hasUnlimitedSlot,
    required this.slot,
    required this.isFree,
    required this.price,
    required this.hasDuration,
    required this.courseStart,
    required this.courseEnd,
    required this.hasDeadline,
    required this.saleStart,
    required this.saleEnd,
    required this.createdAt,
    required this.updatedAt,
    required this.mentor,
    required this.schedule,
    required this.mode,
    required this.office,
    required this.course,
  });

  String id;
  bool hasUnlimitedSlot;
  int slot;
  bool isFree;
  double price;
  bool hasDuration;
  DateTime courseStart;
  DateTime courseEnd;
  bool hasDeadline;
  DateTime saleStart;
  DateTime saleEnd;
  DateTime createdAt;
  DateTime updatedAt;
  Mentor mentor;
  Schedule schedule;
  Mode mode;
  Office office;
  Course course;

  factory CourseOpen.fromJson(Map<String, dynamic> json) => CourseOpen(
        id: json["id"],
        hasUnlimitedSlot: json["has_unlimited_slot"],
        slot: json["slot"],
        isFree: json["is_free"],
        price: json["price"]?.toDouble(),
        hasDuration: json["has_duration"],
        courseStart: DateTime.parse(json["course_start"]),
        courseEnd: DateTime.parse(json["course_end"]),
        hasDeadline: json["has_deadline"],
        saleStart: DateTime.parse(json["sale_start"]),
        saleEnd: DateTime.parse(json["sale_end"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        mentor: Mentor.fromJson(json["mentor"]),
        schedule: Schedule.fromJson(json["schedule"]),
        mode: Mode.fromJson(json["mode"]),
        office: Office.fromJson(json["office"]),
        course: Course.fromJson(json["course"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "has_unlimited_slot": hasUnlimitedSlot,
        "slot": slot,
        "is_free": isFree,
        "price": price,
        "has_duration": hasDuration,
        "course_start": courseStart.toIso8601String(),
        "course_end": courseEnd.toIso8601String(),
        "has_deadline": hasDeadline,
        "sale_start":
            "${saleStart.year.toString().padLeft(4, '0')}-${saleStart.month.toString().padLeft(2, '0')}-${saleStart.day.toString().padLeft(2, '0')}",
        "sale_end":
            "${saleEnd.year.toString().padLeft(4, '0')}-${saleEnd.month.toString().padLeft(2, '0')}-${saleEnd.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "mentor": mentor.toJson(),
        "schedule": schedule.toJson(),
        "mode": mode.toJson(),
        "office": office.toJson(),
        "course": course.toJson(),
      };
}

class Course {
  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updateAt,
    required this.category,
  });

  String id;
  String name;
  String description;
  dynamic image;
  DateTime createdAt;
  DateTime updateAt;
  Category category;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "category": category.toJson(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isActive,
  });

  String id;
  String name;
  String description;
  String image;
  bool isActive;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "is_active": isActive,
      };
}

class Mentor {
  Mentor({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.dniCe,
    required this.email,
    required this.isActive,
    required this.roles,
    required this.createdAt,
    required this.updateAt,
    required this.profile,
  });

  String id;
  String firstName;
  String lastName;
  String? dniCe;
  String email;
  bool isActive;
  List<String> roles;
  DateTime createdAt;
  DateTime updateAt;
  Profile profile;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dniCe: json["dni_ce"],
        email: json["email"],
        isActive: json["is_active"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "dni_ce": dniCe,
        "email": email,
        "is_active": isActive,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.id,
    required this.dateOfBirth,
    required this.isMale,
    required this.urlImage,
    required this.personalNumber,
    required this.experience,
  });

  String id;
  DateTime dateOfBirth;
  bool isMale;
  String urlImage;
  String personalNumber;
  int experience;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        isMale: json["is_male"],
        urlImage: json["url_image"],
        personalNumber: json["personal_number"],
        experience: json["experience"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "is_male": isMale,
        "url_image": urlImage,
        "personal_number": personalNumber,
        "experience": experience,
      };
}

class Mode {
  Mode({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Mode.fromJson(Map<String, dynamic> json) => Mode(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Office {
  Office({
    required this.id,
    required this.name,
    required this.address,
    required this.district,
  });

  String id;
  String name;
  String address;
  District district;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        district: District.fromJson(json["district"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "district": district.toJson(),
      };
}

class District {
  District({
    required this.id,
    required this.name,
    required this.province,
  });

  String id;
  String name;
  Province province;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        province: Province.fromJson(json["province"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "province": province.toJson(),
      };
}

class Province {
  Province({
    required this.id,
    required this.name,
    required this.department,
  });

  String id;
  String name;
  Mode department;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
        department: Mode.fromJson(json["department"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department": department.toJson(),
      };
}

class Schedule {
  Schedule({
    required this.id,
    required this.name,
    required this.scheduleDetail,
  });

  String id;
  String name;
  List<ScheduleDetail> scheduleDetail;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        name: json["name"],
        scheduleDetail: List<ScheduleDetail>.from(
            json["scheduleDetail"].map((x) => ScheduleDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "scheduleDetail":
            List<dynamic>.from(scheduleDetail.map((x) => x.toJson())),
      };
}

class ScheduleDetail {
  ScheduleDetail({
    required this.id,
    required this.day,
    required this.timeIn,
    required this.timeOut,
  });

  String id;
  int day;
  String timeIn;
  String timeOut;

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) => ScheduleDetail(
        id: json["id"],
        day: json["day"],
        timeIn: json["time_in"],
        timeOut: json["time_out"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "time_in": timeIn,
        "time_out": timeOut,
      };
}
