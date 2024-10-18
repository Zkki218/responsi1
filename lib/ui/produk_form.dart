import 'package:flutter/material.dart';
import 'package:responsi1/bloc/produk_bloc.dart';
import 'package:responsi1/model/produk.dart';
import 'package:responsi1/ui/produk_page.dart';
import 'package:responsi1/widget/success_dialog.dart';
import 'package:responsi1/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TERJEMAHAN";
  String tombolSubmit = "SIMPAN";
  final _originalLanguageTextboxController = TextEditingController();
  final _translatedLanguageTextboxController = TextEditingController();
  final _translatorNameTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH TERJEMAHAN";
        tombolSubmit = "UBAH";
        _originalLanguageTextboxController.text = widget.produk!.original_language!;
        _translatedLanguageTextboxController.text = widget.produk!.translated_language!;
        _translatorNameTextboxController.text = widget.produk!.translator_name!;
      });
    } else {
      judul = "TAMBAH TERJEMAHAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                const SizedBox(height: 16),
                _namaProdukTextField(),
                const SizedBox(height: 16),
                _hargaProdukTextField(),
                const SizedBox(height: 16),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Bahasa Asli"),
      keyboardType: TextInputType.text,
      controller: _originalLanguageTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bahasa Asli harus diisi";
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Bahasa Terjemahan"),
      keyboardType: TextInputType.text,
      controller: _translatedLanguageTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bahasa Terjemahan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Penerjemah"),
      keyboardType: TextInputType.number,
      controller: _translatorNameTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Penerjemah harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(
            tombolSubmit,
            style: const TextStyle(
              color: Colors.white
            ),
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.original_language = _originalLanguageTextboxController.text;
    createProduk.translated_language = _translatedLanguageTextboxController.text;
    createProduk.translator_name = _translatorNameTextboxController.text;
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      if (value['status']) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Terjemahan berhasil ditambahkan",
            okClick: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const ProdukPage(),
                ),
              );
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
            description: value['message'],
          ),
        );
      }
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.original_language = _originalLanguageTextboxController.text;
    updateProduk.translated_language = _translatedLanguageTextboxController.text;
    updateProduk.translator_name = _translatorNameTextboxController.text;
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SuccessDialog(
          description: "Terjemahan berhasil diubah",
          okClick: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const ProdukPage(),
              ),
            );
          },
        ),
      );
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}