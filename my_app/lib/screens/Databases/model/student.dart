class Student {
  int? id;
  String name;
  String course;
  int age;

// Student Constructor
  Student({
    this.id,
    required this.name,
    required this.course,
    required this.age,
  });

// Convert Student into Map and store into DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'age': age,
    };
  }
// Read Data from DB and convert into Scheme understandable by App
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      course: map['course'],
      age: map['age'],
    );
  }
}