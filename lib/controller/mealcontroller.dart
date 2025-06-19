  import 'dart:developer';
  import 'package:http/http.dart' as http;
  import 'package:get/get.dart';
  import 'package:iroidmedic/core/baseurl.dart';
  import 'package:iroidmedic/model/mealmodel.dart';

  class MealController extends GetxController {
    Mealmodel? mealmodel;
    RxBool dataloading = false.obs;
    RxSet<int> expandedIndexes = <int>{}.obs;

    loadmealdata() async {
      try {
        dataloading.value = true;
        var response = await http
            .get(Uri.parse("${Baseurl.BaseUrl}get-mealcategories?lang_id=en"));
        log("response : ${response.body}");
        if (response.statusCode == 200) {
          mealmodel = mealmodelFromJson(response.body);
          dataloading.value = false;
        } else {
          dataloading.value = false;
        }
      } catch (e) {
        dataloading.value = false;
        log("error in mealdata: $e");
      }
    }

    @override
    void onInit() {
      loadmealdata();
      // TODO: implement onInit
      super.onInit();
    }
  }
