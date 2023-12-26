class InboxModel {
  String message;
  String image;
  bool isUnread;
  InboxModel({
    required this.image,
    required this.message,
    this.isUnread = false,
  });
}

List<InboxModel> inboxList = [
  InboxModel(
    image: 'assets/images/bday.png',
    message: 'Happy birthday, Alice!',
    isUnread: true,
  ),
  InboxModel(
    image: 'assets/images/bday.png',
    message: 'Did you know that by age 11 months bab',
  ),
  InboxModel(
    image: 'assets/images/bday.png',
    message: 'Congratulations! 9 m',
  ),
  InboxModel(
    image: 'assets/images/bday.png',
    message: 'Did you know that by age 11 months bab',
  ),
  InboxModel(
    image: 'assets/images/bday.png',
    message: 'Did you know that by age 11 months bab',
  ),
  InboxModel(
    image: 'assets/images/bday.png',
    message: 'Congratulations! 9 m',
  ),
  InboxModel(
    image: 'assets/images/bday.png',
    message: 'Congratulations! 9 m',
  ),
];
