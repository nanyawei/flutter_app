class HomeModel {
  String sId;
  String cnDescription;
  String cnName;
  String creationTime;
  String description;
  String image;
  String modifiedTime;
  String name;
  String uploaderId;

  HomeModel(
      {this.sId,
      this.cnDescription,
      this.cnName,
      this.creationTime,
      this.description,
      this.image,
      this.modifiedTime,
      this.name,
      this.uploaderId});

  HomeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cnDescription = json['cnDescription'];
    cnName = json['cnName'];
    creationTime = json['creationTime'];
    description = json['description'];
    image = json['image'];
    modifiedTime = json['modifiedTime'];
    name = json['name'];
    uploaderId = json['uploaderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cnDescription'] = this.cnDescription;
    data['cnName'] = this.cnName;
    data['creationTime'] = this.creationTime;
    data['description'] = this.description;
    data['image'] = this.image;
    data['modifiedTime'] = this.modifiedTime;
    data['name'] = this.name;
    data['uploaderId'] = this.uploaderId;
    return data;
  }
}

class RoomModel {
  String sId;
  String areaID;
  String cnDescription;
  String cnName;
  String creationTime;
  String description;
  String homeID;
  String imageUrl;
  String modifiedTime;
  String name;
  List<String> rolesID;
  String uploaderId;

  RoomModel(
      {this.sId,
      this.areaID,
      this.cnDescription,
      this.cnName,
      this.creationTime,
      this.description,
      this.homeID,
      this.imageUrl,
      this.modifiedTime,
      this.name,
      this.rolesID,
      this.uploaderId});

  RoomModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    areaID = json['areaID'];
    cnDescription = json['cnDescription'];
    cnName = json['cnName'];
    creationTime = json['creationTime'];
    description = json['description'];
    homeID = json['homeID'];
    imageUrl = json['imageUrl'];
    modifiedTime = json['modifiedTime'];
    name = json['name'];
    rolesID = json['rolesID'] != null ? json['rolesID'].cast<String>() : [];
    uploaderId = json['uploaderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['areaID'] = this.areaID;
    data['cnDescription'] = this.cnDescription;
    data['cnName'] = this.cnName;
    data['creationTime'] = this.creationTime;
    data['description'] = this.description;
    data['homeID'] = this.homeID;
    data['imageUrl'] = this.imageUrl;
    data['modifiedTime'] = this.modifiedTime;
    data['name'] = this.name;
    data['rolesID'] = this.rolesID;
    data['uploaderId'] = this.uploaderId;
    return data;
  }
}

class GroupLampModel {
  String sId;
  String areaID;
  bool closeFlag;
  String cnDescription;
  String cnName;
  String creationTime;
  String description;
  String homeID;
  int level;
  GroupLampMetadata metadata;
  String modifiedTime;
  String name;
  List<String> rolesID;
  String roomID;
  String shortId;
  String type;
  String uploaderId;

  GroupLampModel(
      {this.sId,
      this.areaID,
      this.closeFlag,
      this.cnDescription,
      this.cnName,
      this.creationTime,
      this.description,
      this.homeID,
      this.level,
      this.metadata,
      this.modifiedTime,
      this.name,
      this.rolesID,
      this.roomID,
      this.shortId,
      this.type,
      this.uploaderId});

  GroupLampModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    areaID = json['areaID'];
    closeFlag = json['closeFlag'];
    cnDescription = json['cnDescription'];
    cnName = json['cnName'];
    creationTime = json['creationTime'];
    description = json['description'];
    homeID = json['homeID'];
    level = json['level'];
    metadata = json['metadata'] != null
        ? new GroupLampMetadata.fromJson(json['metadata'])
        : null;
    modifiedTime = json['modifiedTime'];
    name = json['name'];
    rolesID = json['rolesID'].cast<String>();
    roomID = json['roomID'];
    shortId = json['shortId'];
    type = json['type'];
    uploaderId = json['uploaderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['areaID'] = this.areaID;
    data['closeFlag'] = this.closeFlag;
    data['cnDescription'] = this.cnDescription;
    data['cnName'] = this.cnName;
    data['creationTime'] = this.creationTime;
    data['description'] = this.description;
    data['homeID'] = this.homeID;
    data['level'] = this.level;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    data['modifiedTime'] = this.modifiedTime;
    data['name'] = this.name;
    data['rolesID'] = this.rolesID;
    data['roomID'] = this.roomID;
    data['shortId'] = this.shortId;
    data['type'] = this.type;
    data['uploaderId'] = this.uploaderId;
    return data;
  }
}

class GroupLampMetadata {
  int groupNumber;

  GroupLampMetadata({this.groupNumber});

  GroupLampMetadata.fromJson(Map<String, dynamic> json) {
    groupNumber = json['groupNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupNumber'] = this.groupNumber;
    return data;
  }
}

class CurtainModel {
  String sId;
  String areaID;
  String cnDescription;
  String cnName;
  String creationTime;
  String description;
  String homeID;
  int level;
  CurtainMetadata metadata;
  String modifiedTime;
  String name;
  List<String> rolesID;
  String roomID;
  String shortId;
  String status;
  String type;
  String uploaderId;

  CurtainModel(
      {this.sId,
      this.areaID,
      this.cnDescription,
      this.cnName,
      this.creationTime,
      this.description,
      this.homeID,
      this.level,
      this.metadata,
      this.modifiedTime,
      this.name,
      this.rolesID,
      this.roomID,
      this.shortId,
      this.status,
      this.type,
      this.uploaderId});

  CurtainModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    areaID = json['areaID'];
    cnDescription = json['cnDescription'];
    cnName = json['cnName'];
    creationTime = json['creationTime'];
    description = json['description'];
    homeID = json['homeID'];
    level = json['level'];
    metadata = json['metadata'] != null
        ? new CurtainMetadata.fromJson(json['metadata'])
        : null;
    modifiedTime = json['modifiedTime'];
    name = json['name'];
    rolesID = json['rolesID'].cast<String>();
    roomID = json['roomID'];
    shortId = json['shortId'];
    status = json['status'];
    type = json['type'];
    uploaderId = json['uploaderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['areaID'] = this.areaID;
    data['cnDescription'] = this.cnDescription;
    data['cnName'] = this.cnName;
    data['creationTime'] = this.creationTime;
    data['description'] = this.description;
    data['homeID'] = this.homeID;
    data['level'] = this.level;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    data['modifiedTime'] = this.modifiedTime;
    data['name'] = this.name;
    data['rolesID'] = this.rolesID;
    data['roomID'] = this.roomID;
    data['shortId'] = this.shortId;
    data['status'] = this.status;
    data['type'] = this.type;
    data['uploaderId'] = this.uploaderId;
    return data;
  }
}

class CurtainMetadata {
  int downBCMPin;
  int upBCMPin;
  String url;

  CurtainMetadata({this.downBCMPin, this.upBCMPin, this.url});

  CurtainMetadata.fromJson(Map<String, dynamic> json) {
    downBCMPin = json['DownBCMPin'];
    upBCMPin = json['UpBCMPin'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DownBCMPin'] = this.downBCMPin;
    data['UpBCMPin'] = this.upBCMPin;
    data['url'] = this.url;
    return data;
  }
}

class DoorModel {
  String sId;
  String areaID;
  bool closeFlag;
  String cnDescription;
  String cnName;
  String creationTime;
  String description;
  String homeID;
  List<KbStatusHistory> kbStatusHistory;
  int level;
  DoorMetadata metadata;
  String modifiedTime;
  String name;
  List<String> rolesID;
  String roomID;
  String shortId;
  String status;
  String type;
  String uploaderId;

  DoorModel(
      {this.sId,
      this.areaID,
      this.closeFlag,
      this.cnDescription,
      this.cnName,
      this.creationTime,
      this.description,
      this.homeID,
      this.kbStatusHistory,
      this.level,
      this.metadata,
      this.modifiedTime,
      this.name,
      this.rolesID,
      this.roomID,
      this.shortId,
      this.status,
      this.type,
      this.uploaderId});

  DoorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    areaID = json['areaID'];
    closeFlag = json['closeFlag'];
    cnDescription = json['cnDescription'];
    cnName = json['cnName'];
    creationTime = json['creationTime'];
    description = json['description'];
    homeID = json['homeID'];
    if (json['kb_status_history'] != null) {
      kbStatusHistory = new List<KbStatusHistory>();
      json['kb_status_history'].forEach((v) {
        kbStatusHistory.add(new KbStatusHistory.fromJson(v));
      });
    }
    level = json['level'];
    metadata = json['metadata'] != null
        ? new DoorMetadata.fromJson(json['metadata'])
        : null;
    modifiedTime = json['modifiedTime'];
    name = json['name'];
    rolesID = json['rolesID'].cast<String>();
    roomID = json['roomID'];
    shortId = json['shortId'];
    status = json['status'];
    type = json['type'];
    uploaderId = json['uploaderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['areaID'] = this.areaID;
    data['closeFlag'] = this.closeFlag;
    data['cnDescription'] = this.cnDescription;
    data['cnName'] = this.cnName;
    data['creationTime'] = this.creationTime;
    data['description'] = this.description;
    data['homeID'] = this.homeID;
    if (this.kbStatusHistory != null) {
      data['kb_status_history'] =
          this.kbStatusHistory.map((v) => v.toJson()).toList();
    }
    data['level'] = this.level;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    data['modifiedTime'] = this.modifiedTime;
    data['name'] = this.name;
    data['rolesID'] = this.rolesID;
    data['roomID'] = this.roomID;
    data['shortId'] = this.shortId;
    data['status'] = this.status;
    data['type'] = this.type;
    data['uploaderId'] = this.uploaderId;
    return data;
  }
}

class KbStatusHistory {
  String data;
  String date;

  KbStatusHistory({this.data, this.date});

  KbStatusHistory.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['date'] = this.date;
    return data;
  }
}

class DoorMetadata {
  int bcmPIN;
  String url;

  DoorMetadata({this.bcmPIN, this.url});

  DoorMetadata.fromJson(Map<String, dynamic> json) {
    bcmPIN = json['bcmPIN'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bcmPIN'] = this.bcmPIN;
    data['url'] = this.url;
    return data;
  }
}
