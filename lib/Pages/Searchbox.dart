import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final Function(String) onSubmitted;

  SearchBox({
    required this.searchController,
    required this.searchFocusNode,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 16,
      right: 16,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: searchController,
          focusNode: searchFocusNode,
          decoration: InputDecoration(
            hintText: 'Search or type URL',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            contentPadding: EdgeInsets.only(top: 12),
          ),
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
