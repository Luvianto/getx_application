String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email harus diisi!';
  }
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Email tidak valid!';
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Nomor Telepon harus diisi!';
  }
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Nomor Telepon tidak valid!';
  }
  if (value.length < 10) {
    return 'Nomor harus memiliki 10 atau lebih karakter!';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password harus diisi!';
  }
  if (value.length < 8) {
    return 'Password harus memiliki 8 atau lebih karakter!';
  }
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Konfirmasi Password harus diisi!';
  }
  if (value != password) {
    return 'Konfirmasi Password tidak sama!';
  }
  return null;
}

String? validateNull(String? value) {
  if (value == null || value.isEmpty) {
    return 'Kolom di atas harus diisi!';
  }
  return null;
}
