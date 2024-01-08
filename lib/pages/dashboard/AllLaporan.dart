import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/components/list_item.dart';
import 'package:lapor_book/models/akun.dart';
import 'package:lapor_book/models/laporan.dart';

class AllLaporan extends StatefulWidget {
  final Akun akun;
  AllLaporan({super.key, required this.akun});

  @override
  State<AllLaporan> createState() => _AllLaporanState();
}

class _AllLaporanState extends State<AllLaporan> {
  final _firestore = FirebaseFirestore.instance;

  List<Laporan> listLaporan = [];

  void getTransaksi() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('laporan').get();

      setState(() {
        listLaporan.clear();
        for (var documents in querySnapshot.docs) {
          // List<dynamic>? komentarData = documents.data()['komentar'];

          // List<Komentar>? listKomentar = komentarData?.map((map) {
          //   return Komentar(
          //     nama: map['nama'],
          //     isi: map['isi'],
          //   );
          // }).toList();

          debugPrint("sampai sini bray");
          debugPrint("${documents.data()}");

          listLaporan.add(
            Laporan(
              // komentar: listKomentar,
              deskripsi: documents.data()['deskripsi'] ?? "",
              docId: documents.data()['docId'] ?? "",
              gambar: documents.data()['gambar'] ?? "",
              instansi: documents.data()['instansi'] ?? "",
              judul: documents.data()['judul'] ?? "",
              maps: documents.data()['maps'] ?? "",
              nama: documents.data()['nama'] ?? "",
              status: documents.data()['status'] ?? "",
              tanggal: documents['tanggal'].toDate(),
              uid: "", // documents.data()['uid'],
            ),
          );

          debugPrint("sampai sini gan");
        }
      });
    } catch (e) {
      debugPrint("sampai sini broo");
      final snackbar = SnackBar(content: Text(e.toString()));
      debugPrint("sampai sini lagi");
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getTransaksi();

    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 1.234,
            ),
            itemCount: listLaporan.length,
            itemBuilder: (context, index) {
              // return Text("$index ${listLaporan[index].judul}");
              return ListItem(
                laporan: listLaporan[index],
                akun: widget.akun,
                isLaporanku: false,
              );
            }),
      ),
    );
  }
}
