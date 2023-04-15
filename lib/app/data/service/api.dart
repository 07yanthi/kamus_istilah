import 'package:news_app/app/data/model/jenis_model.dart';
import 'package:news_app/app/data/model/kamus_model.dart';
import 'package:http/http.dart' as http;
import 'package:unique_identifier/unique_identifier.dart';

class FetchFromApi {
  

  Future<KamusModel?> getKamus(String search) async {
    var response = await http.get(Uri.parse(
        'http://kamus.test-web.my.id/api/get_kamus?search=' + search));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return kamusModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<KamusModel?> getFavorit() async {
    String? user = await UniqueIdentifier.serial;
    var response = await http.get(Uri.parse(
        'http://kamus.test-web.my.id/api/list_favorit?user=' + user!));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return kamusModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load news');
    }
  }


}
