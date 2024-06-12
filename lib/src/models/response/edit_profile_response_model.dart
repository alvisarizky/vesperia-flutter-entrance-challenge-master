class EditProfileModel {
  final int? status;
  final String? message;
  final Data? data;

  EditProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? profilePictureUrl;

  Data({
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.dateOfBirth,
    this.gender,
    this.profilePictureUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profilePicture: json["profile_picture"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        profilePictureUrl: json["profile_picture_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "profile_picture": profilePicture,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "profile_picture_url": profilePictureUrl,
      };
}
