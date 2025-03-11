import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:taverna_italiana/core/styles/app_colors.dart';

class RecipeFilterWidget extends HookWidget {
  final List<String> filters;
  final ValueChanged<String> onSelected;

  const RecipeFilterWidget({
    super.key,
    required this.filters,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState<String>(filters.first);

    return SizedBox(
      height: 32.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.map((filter) {
          return GestureDetector(
            onTap: () {
              selectedFilter.value = filter;
              onSelected(filter);
            },
            child: Container(
              alignment: Alignment.center,
              width: 120,
              margin: const EdgeInsets.only(left: 16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: selectedFilter.value == filter
                    ? AppColors.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(48.0),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: selectedFilter.value == filter
                      ? Colors.white
                      : Colors.black54,
                  fontWeight: selectedFilter.value == filter
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
