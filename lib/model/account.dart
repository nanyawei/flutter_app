class LoginModel {
  String loginname;
  String password;

  LoginModel({this.loginname, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    loginname = json['loginname'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginname'] = this.loginname;
    data['password'] = this.password;
    return data;
  }
}

class TokenModel {
  String jwt;

  TokenModel({this.jwt});

  TokenModel.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    return data;
  }
}

class MyModel {
  String description;
  bool masterFlag;
  String sId;
  String active;
  String chinesename;
  String creationTime;
  String email;
  String firstname;
  String gender;
  List<String> groupId;
  String lastLoginTime;
  String lastname;
  String modifiedTime;
  String type;
  int viplevel;

  MyModel(
      {this.description,
      this.masterFlag,
      this.sId,
      this.active,
      this.chinesename,
      this.creationTime,
      this.email,
      this.firstname,
      this.gender,
      this.groupId,
      this.lastLoginTime,
      this.lastname,
      this.modifiedTime,
      this.type,
      this.viplevel});

  MyModel.fromJson(Map<String, dynamic> json) {
    description = json['Description'];
    masterFlag = json['MasterFlag'];
    sId = json['_id'];
    active = json['active'];
    chinesename = json['chinesename'];
    creationTime = json['creationTime'];
    email = json['email'];
    firstname = json['firstname'];
    gender = json['gender'];
    groupId = json['group_id'].cast<String>();
    lastLoginTime = json['lastLoginTime'];
    lastname = json['lastname'];
    modifiedTime = json['modifiedTime'];
    type = json['type'];
    viplevel = json['viplevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Description'] = this.description;
    data['MasterFlag'] = this.masterFlag;
    data['_id'] = this.sId;
    data['active'] = this.active;
    data['chinesename'] = this.chinesename;
    data['creationTime'] = this.creationTime;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['gender'] = this.gender;
    data['group_id'] = this.groupId;
    data['lastLoginTime'] = this.lastLoginTime;
    data['lastname'] = this.lastname;
    data['modifiedTime'] = this.modifiedTime;
    data['type'] = this.type;
    data['viplevel'] = this.viplevel;
    return data;
  }
}
