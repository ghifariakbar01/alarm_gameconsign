// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlarmModel {
  String? id;
  final DateTime date;
  final String nama;
  AlarmModel({
    this.id,
    required this.date,
    required this.nama,
  });

  AlarmModel copyWith({
    String? id,
    DateTime? date,
    String? nama,
  }) {
    return AlarmModel(
      id: id ?? this.id,
      date: date ?? this.date,
      nama: nama ?? this.nama,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'nama': nama,
    };
  }

  factory AlarmModel.fromMap(Map<String, dynamic> map) {
    return AlarmModel(
      id: map['id'] != null ? map['id'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      nama: map['nama'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlarmModel.fromJson(String source) =>
      AlarmModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AlarmModel(id: $id, date: $date, nama: $nama)';

  @override
  bool operator ==(covariant AlarmModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.date == date && other.nama == nama;
  }

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ nama.hashCode;
}
