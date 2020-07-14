// To parse this JSON data, do
//
//     final trx = trxFromJson(jsonString);

import 'dart:convert';

List<Trx> trxFromJson(String str) =>
    List<Trx>.from(json.decode(str).map((x) => Trx.fromJson(x)));

String trxToJson(List<Trx> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trx {
  int status;
  String user;
  String nomorhp;
  String gambar;
  String nama;
  int jumlah;
  int subtotal;

  Trx({
    this.status,
    this.user,
    this.nomorhp,
    this.gambar,
    this.nama,
    this.jumlah,
    this.subtotal,
  });

  factory Trx.fromJson(Map<String, dynamic> json) => Trx(
        status: json["status"],
        user: json["user"],
        nomorhp: json["nomorhp"],
        gambar: json["gambar"],
        nama: json["nama"],
        jumlah: json["jumlah"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user,
        "nomorhp": nomorhp,
        "gambar": gambar,
        "nama": nama,
        "jumlah": jumlah,
        "subtotal": subtotal,
      };
}
