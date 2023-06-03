import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback onClose;
  final TextEditingController textController;

  const SearchBar({
    required this.hintText,
    required this.onClose,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              textController.clear();
            },
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
