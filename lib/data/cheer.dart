class Cheer {
  String senderEmail;
  String senderName;
  String senderImgData;
  String receiverName;
  String senderRole;
  String receiverEmail;
  String cheerMsg;
  String title;
  int color;
  int label;
  String category;
  DateTime createdAt;

  Cheer();

  Cheer.name(
      this.title,
      this.senderEmail,
      this.senderName,
      this.senderImgData,
      this.receiverName,
      this.senderRole,
      this.receiverEmail,
      this.cheerMsg,
      this.color,
      this.label,
      this.category,
      this.createdAt);

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'senderEmail': this.senderEmail,
      'senderImgData': this.senderImgData,
      'senderRole': this.senderRole,
      'receiverEmail': this.receiverEmail,
      'senderName': this.senderName,
      'receiverName': this.receiverName,
      'cheerMsg': this.cheerMsg,
      'color': this.color,
      'label': this.label,
      'category': this.category,
      'createdAt': this.createdAt
    };
  }

  Cheer.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        senderImgData = json['senderImgData'],
        senderName = json['senderName'],
        senderEmail = json['senderEmail'],
        receiverEmail = json['receiverEmail'],
        receiverName = json['receiverName'],
        senderRole = json['senderRole'],
        cheerMsg = json['cheerMsg'],
        color = json['color'],
        label = json['label'],
        category = json['category'],
        createdAt = json['createdAt'].toDate();
}
