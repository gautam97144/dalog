class NotificationList {
  String? title;
  String? subTitle;
  String? date;

  NotificationList({this.title, this.subTitle, this.date});
}

List<NotificationList> _notificationList = [
  NotificationList(
      title: "Driver Assigned to your job.",
      subTitle:
          "Your Job “Pickup a Car & bike from Fillmore” assigned to “Feni Olgano”",
      date: "Now"),
  NotificationList(
      title: "Pickup Security Code",
      subTitle:
          "Your Pickup Security Code is DCP5220 for “Pickup a Car & bike from Fillmore.” job",
      date: "Yesterday"),
  NotificationList(
      title: "Pickup Security Code",
      subTitle:
          "Your Pickup Security Code is DCP5220 for “Pickup a Car & bike from Fillmore.” job",
      date: "Yesterday"),
];

List<NotificationList> get notificationList => _notificationList;
