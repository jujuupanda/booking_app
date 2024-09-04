import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.fieldName,
    required this.controller,
    required this.prefixIcon,
    this.role,
  });

  final String fieldName;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String? role;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 12,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText(widget.fieldName, obscureText),
        minLines: 1,
        maxLines: _maxLine(widget.fieldName),
        readOnly: _readOnly(widget.fieldName, widget.role ?? "1"),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: _keyboardType(widget.fieldName),
        inputFormatters: _textInputFormatter(widget.fieldName),
        validator: _customValidator(widget.fieldName),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: _suffixIcon(widget.fieldName),
          hintStyle: GoogleFonts.openSans(),
          hintText: widget.fieldName,
          labelText: _labelText(widget.fieldName),
        ),
      ),
    );
  }

  _labelText(String fieldName){
    if(fieldName == "Keterangan"){
      return "Keterangan (opsional)";
    }
  }

  _suffixIcon(String fieldName) {
    if (widget.fieldName == "Password") {
      return IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed:
            _togglePasswordVisibility, // Memanggil setState untuk mengubah state
      );
    } else {
      return null;
    }
  }

  _maxLine(String fieldName) {
    if (fieldName == "Deskripsi Gedung" ||
        fieldName == "Fasilitas Gedung" ||
        fieldName == "Peraturan Gedung" ||
        fieldName == "Deskripsi Ekstrakurikuler" ||
        fieldName == "Keterangan") {
      return 6;
    } else {
      return 1;
    }
  }

  TextInputType _keyboardType(String fieldName) {
    if (fieldName == "Nomor Telepon" || fieldName == "Kapasitas Gedung") {
      return TextInputType.number;
    } else if (fieldName == "E-Mail") {
      return TextInputType.emailAddress;
    } else if (fieldName == "Deskripsi Gedung" ||
        fieldName == "Fasilitas Gedung" ||
        fieldName == "Peraturan Gedung" ||
        fieldName == "Deskripsi Ekstrakurikuler" ||
        fieldName == "Keterangan") {
      return TextInputType.multiline;
    } else {
      return TextInputType.text;
    }
  }

  List<TextInputFormatter> _textInputFormatter(String fieldName) {
    if (fieldName == "Username") {
      return [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
      ];
    } else if (fieldName == "Password") {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
      ];
    } else if (fieldName == "Nomor Telepon" ||
        fieldName == "Kapasitas Gedung") {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ];
    } else if (fieldName == "E-Mail") {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9@._-]'),
        ),
      ];
    } else if (fieldName == "Nama Lengkap") {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
      ];
    } else if (fieldName == "Nama Gedung" ||
        fieldName == "Nama Ekstrakurikuler") {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
      ];
    } else {
      // Default input formatter
      return [];
    }
  }

  _customValidator(String fieldName) {
    if (fieldName == "Password") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong!';
        }
        // Validasi minimal 1 huruf besar dan kombinasi huruf dan angka
        if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]+$').hasMatch(value)) {
          return 'Password setidaknya mengandung huruf besar dan angka!';
        }
        if (value.length < 6) {
          return 'Password harus lebih dari 6 karakter!';
        }
        return null;
      };
    } else if (fieldName == "E-Mail") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong!';
        }
        // Validasi format email
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Masukkan email dengan benar!';
        }
      };
    } else if (fieldName == "Nomor Telepon") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor telepon tidak boleh kosong!';
        }
        // validator tidak boleh kurang dari 10 digit
        if (value.length < 10 || !value.startsWith('08')) {
          return 'Masukkan nomor telepon dengan benar!';
        }
      };
    } else if (fieldName == "Gambar" || fieldName == "Keterangan") {
      return null;
    } else {
      return (value) {
        if (value == null || value.isEmpty) {
          return '$fieldName tidak boleh kosong!';
        } else {
          return null;
        }
      };
    }
  }

  _readOnly(String fieldName, String role) {
    if (fieldName == "Instansi" && role == "1") {
      return true;
    } else if (fieldName == "Gambar") {
      return true;
    } else {
      return false;
    }
  }

  _obscureText(String fieldName, bool obscureText) {
    if (fieldName == "Password") {
      return obscureText;
    } else {
      return false;
    }
  }
}