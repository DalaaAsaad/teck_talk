import 'package:flutter/material.dart';
import 'package:get/get.dart';

class search_Controller extends GetxController {
  var searchText = ''.obs;

  TextEditingController textController = TextEditingController();
  bool get isSearching => searchText.value.length >= 2;

  void onSearchChanged(String value) {
    searchText.value = value;
    print(searchText.value);
  }

  void clearSearch() {
    textController.clear(); 
    searchText.value = '';
  }
  void setSearchFromTag(String tag) {
  textController.text = tag;
  searchText.value = tag;
}
}
