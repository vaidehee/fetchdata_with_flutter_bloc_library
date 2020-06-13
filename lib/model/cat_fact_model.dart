
class Cats {
  bool used;
  String source;
  String type;
  bool deleted;
  String sId;
  String user;
  String text;
  int iV;
  String updatedAt;
  String createdAt;
  Status status;

  Cats(
      {this.used,
        this.source,
        this.type,
        this.deleted,
        this.sId,
        this.user,
        this.text,
        this.iV,
        this.updatedAt,
        this.createdAt,
        this.status});

  Cats.fromJson(Map<String, dynamic> json) {
    used = json['used'];
    source = json['source'];
    type = json['type'];
    deleted = json['deleted'];
    sId = json['_id'];
    user = json['user'];
    text = json['text'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['used'] = this.used;
    data['source'] = this.source;
    data['type'] = this.type;
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['text'] = this.text;
    data['__v'] = this.iV;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

class Status {
  bool verified;
  int sentCount;

  Status({this.verified, this.sentCount});

  Status.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    sentCount = json['sentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['sentCount'] = this.sentCount;
    return data;
  }
}