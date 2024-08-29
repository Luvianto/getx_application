class AlumniPddiktiModel {
  final String id;
  final String nama;
  final String nim;
  final String namaPts;
  final String singkatanPt;
  final String namaProdi;

  AlumniPddiktiModel({
    required this.id,
    required this.nama,
    required this.nim,
    required this.namaPts,
    required this.singkatanPt,
    required this.namaProdi,
  });

  factory AlumniPddiktiModel.fromJson(Map<String, dynamic> data) {
    return AlumniPddiktiModel(
      id: data['id'] ?? '',
      nama: data['nama'] ?? '',
      nim: data['nim'] ?? '',
      namaPts: data['nama_pts'] ?? '',
      singkatanPt: data['sinkatan_pt'] ?? '',
      namaProdi: data['nama_prodi'] ?? '',
    );
  }
}
