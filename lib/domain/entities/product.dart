class Product {
  late String _productName;
  late int _cost;
  late int _sellingPrice;
  late dynamic _size;
  late String _ref;
  late String _description;
  late int _category;
  late String _brand;

  Product.empty() {
    _productName = '';
    _cost = 0;
    _sellingPrice = 0;
    _size = null;
    _ref = '';
    _description = '';
    _category = 0;
    _brand = '';
  }

  Product(this._productName, this._cost, this._sellingPrice, this._size,
      this._ref, this._description, this._category, this._brand);

  String get productName => _productName;
  int get cost => _cost;
  int get sellingPrice => _sellingPrice;
  dynamic get size => _size;
  String get ref => _ref;
  String get description => _description;
  int get category => _category;
  String get brand => _brand;

  set productName(String value) => _productName = value;
  set cost(int value) => _cost = value;
  set sellingPrice(int value) => _sellingPrice = value;
  set size(dynamic value) => _size = value;
  set ref(String value) => _ref = value;
  set description(String value) => _description = value;
  set category(int value) => _category = value;
  set brand(String value) => _brand = value;
}
