class TodoModel {
  final String title;
  final String keterangan;
  final String tglmulai;
  final String tglselesai;
  final String kategetori;
  final bool isCheck;

  TodoModel({
    required String this.title,
    required String this.keterangan,
    required String this.tglmulai,
    required String this.tglselesai,
    required String this.kategetori,
    required bool this.isCheck,
  });
}
