class Customer {
  String? name;
  int? age;

  Customer(String name, int age) {
    this.name = name;
    this.age = age;
  }

  @override
  String toString() {
    return '{${name}, ${age}}';
  }
}
