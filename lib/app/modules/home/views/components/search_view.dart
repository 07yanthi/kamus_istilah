// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/app/core/env/env.dart';

class SearchView extends StatelessWidget {
  TextEditingController controller;
  Function()? onPressed;

  SearchView({
    required this.controller,
    required this.onPressed,
  });

  final formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // decoration: BoxDecoration(
      //   color: Env.colors.secondryGrey,
      // ),
      child: TextField(
        controller: controller,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
        ], // O
        // keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search ...",
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: controller.text.isEmpty
                ? Icon(Icons.search)
                : Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}
