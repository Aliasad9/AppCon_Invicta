class CustomNotificationData {
  String senderEmail;
  String senderName;
  String senderImgUrl;
  String receiverName;
  String senderRole;
  String receiverEmail;
  String cheerMsg;
  String title;

  DateTime createdAt;
  bool isCheer;
  String companyName;

  CustomNotificationData();

  CustomNotificationData.name(
      this.companyName,
      this.isCheer,
      this.title,
      this.senderEmail,
      this.senderName,
      this.senderImgUrl,
      this.receiverName,
      this.senderRole,
      this.receiverEmail,
      this.cheerMsg,
      this.createdAt);

  Map<String, dynamic> toJson() {
    return {
      'companyName': this.companyName,
      'isCheer': this.isCheer,
      'title': this.title,
      'senderEmail': this.senderEmail,
      'senderImgUrl': this.senderImgUrl,
      'senderRole': this.senderRole,
      'receiverEmail': this.receiverEmail,
      'senderName': this.senderName,
      'receiverName': this.receiverName,
      'cheerMsg': this.cheerMsg,
      'createdAt': this.createdAt
    };
  }

  CustomNotificationData.fromJson(Map<String, dynamic> json)
      : isCheer = json['isCheer'],
        companyName = json['companyName'],
        title = json['title'],
        senderImgUrl = json['senderImgUrl'],
        senderName = json['senderName'],
        senderEmail = json['senderEmail'],
        receiverEmail = json['receiverEmail'],
        receiverName = json['receiverName'],
        senderRole = json['senderRole'],
        cheerMsg = json['cheerMsg'],
        createdAt = json['createdAt'].toDate();
}
