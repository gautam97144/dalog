class MyJob {
  String? title;
  String? amount;
  String? name;
  String? image;
  bool? isSelected;
  MyJob({this.title, this.amount, this.name, this.image, this.isSelected});
}

List<MyJob> myJob = [
  MyJob(
      title: "Pickup a Car & bike from Fillmore",
      amount: "\$35",
      name: "Deni Cobada",
      isSelected: true),
  MyJob(
      title: "Transfer Household Goods",
      amount: "\$225",
      name: "Deni Cobada",
      isSelected: false),
  MyJob(
      title: "Transfer Household Goods",
      amount: "\$225",
      name: "Deni Cobada",
      isSelected: false),
  MyJob(
      title: "Transfer Household Goods",
      amount: "\$225",
      name: "Deni Cobada",
      isSelected: false),
  MyJob(
      title: "Transfer Household Goods",
      amount: "\$225",
      name: "Deni Cobada",
      isSelected: false),
];
