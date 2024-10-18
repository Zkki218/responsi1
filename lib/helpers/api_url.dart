class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/buku/bahasa';
  static const String createProduk = baseUrl + '/buku/bahasa';

  static String updateProduk(int id) {
    return baseUrl + '/buku/bahasa/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrl + '/buku/bahasa/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/buku/bahasa/' + id.toString() + '/delete';
  }
}
