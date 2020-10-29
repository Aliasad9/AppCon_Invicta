class Cheer {
  String senderEmail;
  String senderRole;
  String receiverEmail;
  String cheerMsg;
  int color;
  int label;
  String category;
  DateTime createdAt;

  Cheer();

  Cheer.name(this.senderEmail, this.senderRole, this.receiverEmail,
      this.cheerMsg, this.color, this.label, this.category, this.createdAt);

  Map<String, dynamic> toJson() {
    return {
      'senderEmail': this.senderEmail,
      'senderRole': this.senderRole,
      'receiverEmail': this.receiverEmail,
      'cheerMsg': this.cheerMsg,
      'color': this.color,
      'label': this.label,
      'category': this.category,
      'createdAt': this.createdAt
    };
  }
}
