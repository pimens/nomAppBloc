import 'dart:convert';

List<Makanan> makananFromJson(String str) => List<Makanan>.from(json.decode(str).map((x) => Makanan.fromJson(x)));

String makananToJson(List<Makanan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Makanan {
    String id;
    String nama;
    String harga;
    String gambar;
    String deskripsi;
    String kategori;
    String tmp;

    Makanan({
        this.id,
        this.nama,
        this.harga,
        this.gambar,
        this.deskripsi,
        this.kategori,
        this.tmp,
    });

    factory Makanan.fromJson(Map<String, dynamic> json) => Makanan(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        gambar: json["gambar"],
        deskripsi: json["deskripsi"],
        kategori: json["kategori"],
        tmp: json["tmp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "gambar": gambar,
        "deskripsi": deskripsi,
        "kategori": kategori,
        "tmp": tmp,
    };
}
