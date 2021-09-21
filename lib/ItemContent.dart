class ItemContent {
  String name;
  int price;
  var qty = 1;

  ItemContent(
    this.name,
    this.price,
  );

  static List<ItemContent> content() => [
        ItemContent('Extra Cheese', 10),
        ItemContent('Extra Honey', 10),
        ItemContent('Extra Sugar', 10),
        ItemContent('Extra mayoni', 10),
      ];
}
