class RekapanNilai {
  final String tipe,
      dosenPembimbing,
      namaInstansi,
      waktuMulai,
      pembimbingLapangan,
      waktuBerakhir,
      nilai;
  final List<dynamic> namaAnggota;

  RekapanNilai({
    required this.tipe,
    required this.dosenPembimbing,
    required this.pembimbingLapangan,
    required this.namaInstansi,
    required this.waktuMulai,
    required this.waktuBerakhir,
    required this.nilai,
    required this.namaAnggota,
  });

  RekapanNilai.fromJson(Map<String, dynamic> json)
      : tipe = json['tipe'] ?? "",
        dosenPembimbing = json['dospem'] ?? "",
        pembimbingLapangan = json['pembimbingLapangan'] ?? "-",
        namaInstansi = json['namaPerusahaan'] ?? json['namaInstansi'] ?? "",
        waktuMulai = json['waktuMulai'] ?? "",
        waktuBerakhir = json['waktuBerakhir'] ?? "",
        nilai = json['nilai'] ?? "",
        namaAnggota = json['namaAnggota'] ?? [json['nama']];
}
