class CastDAO {
  int? id_cast;
  String? name;
  String? birth_date;
  int? age;
  String? gender;

  CastDAO({this.id_cast, this.name, this.birth_date, this.age, this.gender});

  factory CastDAO.fromMap(Map<String, dynamic> data) {
    return CastDAO(
      id_cast: data['id_cast'],
      name: data['name'],
      birth_date: data['birth_date'],
      age: data['age'],
      gender: data['gender']
    );
  }

  
}
