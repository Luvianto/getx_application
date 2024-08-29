String? validateEmail(value) {
  if (value == null || value.isEmpty) {
    return 'Email harus diisi';
  }
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Email tidak valid';
  }
  return null;
}

String? validatePhoneNumber(value) {
  if (value == null || value.isEmpty) {
    return 'Nomor telepon harus diisi';
  }
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Nomor telepon tidak valid';
  }
  if (value.length < 10) {
    return 'Nomor Telepon harus memiliki 9 karakter atau lebih';
  }
  return null;
}

String? validatePassword(value) {
  if (value == null || value.isEmpty) {
    return 'Password harus diisi';
  }
  if (value.length < 8) {
    return 'Password harus memiliki 8 karakter atau lebih';
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
