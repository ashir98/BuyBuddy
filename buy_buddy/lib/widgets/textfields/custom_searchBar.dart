// ignore_for_file: must_be_immutable, file_names

import 'package:buy_buddy/utils/app_colors.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {

  TextEditingController controller;
  final ValueChanged onChanged;
  
  SearchBar({
    super.key, 
    required this.controller, 
    required this.onChanged
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07), // Shadow color
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1.5), // Shadow position
          )
        ]),
        child: TextFormField(
          onChanged: widget.onChanged,
          keyboardType: TextInputType.text,
          controller: widget.controller,
          style: TextStyle(color: AppColor.subTitleColor, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              prefixIcon: Icon(EneftyIcons.search_normal_2_outline, color: AppColor.iconColor),
              hintText: "Search top selling products...",
              border: InputBorder.none,
              filled: true,
              fillColor: AppColor.cardBgColor,
              contentPadding: const EdgeInsets.all(17)),
        ),
      ),
    );
  }
}
