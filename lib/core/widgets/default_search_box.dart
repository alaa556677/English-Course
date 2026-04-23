import 'package:flutter/material.dart';

class SearchTextForm extends StatelessWidget {
  final TextEditingController searchController;
  final double radius;
  final Function(String)? onChanged;

  const SearchTextForm({
    super.key,
    required this.searchController,
    this.radius = 14,
    this.onChanged,
    // kept for backward compat
    Color borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: TextFormField(
        controller: searchController,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.50), size: 20),
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
