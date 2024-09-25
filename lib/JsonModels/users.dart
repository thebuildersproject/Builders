// Create users Json Models
class Users {
  final int? usrId; // Changed this from usrID to usrId for consistency
  final String usrName;
  final String usrPassword;

  Users({
    this.usrId,
    required this.usrName,
    required this.usrPassword,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"], // Changed this from usrID to usrId
    usrName: json["usrName"],
    usrPassword: json["usrPassword"],
  );

  Map<String, dynamic> toMap() => {
    "usrId": usrId, // Changed this from usrID to usrId
    "usrName": usrName,
    "usrPassword": usrPassword,
  };
}
