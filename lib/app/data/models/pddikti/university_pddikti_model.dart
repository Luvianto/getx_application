class UniversityPddiktiModel {
  String idSp;
  String kabKotaPt;
  String provinsiPt;
  String akreditasi;
  String namaSingkat;
  String statusPt;
  String namaPt;
  String jenisPt;
  int jumlahProdi;
  String rangeBiayaKuliah;

  UniversityPddiktiModel({
    required this.idSp,
    required this.kabKotaPt,
    required this.provinsiPt,
    required this.akreditasi,
    required this.namaSingkat,
    required this.statusPt,
    required this.namaPt,
    required this.jenisPt,
    required this.jumlahProdi,
    required this.rangeBiayaKuliah,
  });

  factory UniversityPddiktiModel.fromJson(Map<String, dynamic> json) {
    return UniversityPddiktiModel(
      idSp: json['id_sp'] ?? '',
      kabKotaPt: json['kab_kota_pt'] ?? '',
      provinsiPt: json['provinsi_pt'] ?? '',
      akreditasi: json['akreditasi'] ?? '',
      namaSingkat: json['nama_singkat'] ?? '',
      statusPt: json['status_pt'] ?? '',
      namaPt: json['nama_pt'] ?? '',
      jenisPt: json['jenis_pt'] ?? '',
      jumlahProdi: json['jumlah_prodi'] ?? '',
      rangeBiayaKuliah: json['range_biaya_kuliah'] ?? '',
    );
  }
}
