import 'package:flutter/material.dart';
import 'package:responsi1/bloc/produk_bloc.dart';
import 'package:responsi1/model/produk.dart';
import 'package:responsi1/ui/produk_form.dart';
import 'package:responsi1/ui/produk_page.dart';
import 'package:responsi1/widget/success_dialog.dart';
import 'package:responsi1/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Bahasa Asli : ${widget.produk!.original_language}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Bahasa Translasi : ${widget.produk!.translated_language}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Penerjemah : ${widget.produk!.translator_name}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text(
              "EDIT",
              style: TextStyle(
                color: Colors.white
              ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
        OutlinedButton(
          child: const Text(
              "DELETE",
              style: TextStyle(
                  color: Colors.white
              ),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    if (widget.produk?.id == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "ID produk tidak ditemukan, tidak bisa menghapus.",
        ),
      );
      return;
    }

    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text(
              "Ya",
              style: TextStyle(
                  color: Colors.white
              ),
          ),
          onPressed: () async {
            bool success = await ProdukBloc.deleteProduk(
                id: widget.produk!.id!);
            if (success) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => SuccessDialog(
                  description: "Produk berhasil dihapus",
                  okClick: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ProdukPage(),
                      ),
                    );
                  },
                ),
              );
            } else {
              // Jika penghapusan gagal
              showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                  description: "Hapus gagal, silahkan coba lagi",
                ),
              );
            }
          },
        ),
        OutlinedButton(
          child: const Text(
              "Batal",
              style: TextStyle(
                  color: Colors.white
              ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}