class ListOfUsers {
  String? _status;
  List<Data>? _data;
  String? _message;

  ListOfUsers({String? status, List<Data>? data, String? message}) {
    if (status != null) {
      _status = status;
    }
    if (data != null) {
      _data = data;
    }
    if (message != null) {
      _message = message;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;

  ListOfUsers.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    data['message'] = _message;
    return data;
  }
}

class Data {
  int? _id;
  String? _employeeName;
  int? _employeeSalary;
  int? _employeeAge;
  String? _profileImage;

  Data(
      {int? id,
      String? employeeName,
      int? employeeSalary,
      int? employeeAge,
      String? profileImage}) {
    if (id != null) {
      _id = id;
    }
    if (employeeName != null) {
      _employeeName = employeeName;
    }
    if (employeeSalary != null) {
      _employeeSalary = employeeSalary;
    }
    if (employeeAge != null) {
      _employeeAge = employeeAge;
    }
    if (profileImage != null) {
      _profileImage = profileImage;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get employeeName => _employeeName;
  set employeeName(String? employeeName) => _employeeName = employeeName;
  int? get employeeSalary => _employeeSalary;
  set employeeSalary(int? employeeSalary) => _employeeSalary = employeeSalary;
  int? get employeeAge => _employeeAge;
  set employeeAge(int? employeeAge) => _employeeAge = employeeAge;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _employeeName = json['employee_name'];
    _employeeSalary = json['employee_salary'];
    _employeeAge = json['employee_age'];
    _profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['employee_name'] = _employeeName;
    data['employee_salary'] = _employeeSalary;
    data['employee_age'] = _employeeAge;
    data['profile_image'] = _profileImage;
    return data;
  }
}
