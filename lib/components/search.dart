import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.onChanged});
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade900,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
