import 'dart:convert';

List<Cabang> cabangFromJson(String str) =>
    List<Cabang>.from(json.decode(str).map((x) => Cabang.fromJson(x)));

String cabangToJson(List<Cabang> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cabang {
  int id;
  String alamat;
  String deskripsi;
  String nama;

  Cabang({
    this.id,
    this.alamat,
    this.deskripsi,
    this.nama,
  });

  factory Cabang.fromJson(Map<String, dynamic> json) => Cabang(
        id: json["id"],
        alamat: json["alamat"],
        deskripsi: json["deskripsi"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alamat": alamat,
        "deskripsi": deskripsi,
        "nama": nama,
      };
}
