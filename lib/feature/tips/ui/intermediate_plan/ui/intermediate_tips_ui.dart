import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/common_page/controller/health_controller.dart';
import 'package:prettyrini/feature/common_page/model/health_card_model.dart';
import 'package:prettyrini/feature/common_page/widget/widget_card.dart';
import 'package:prettyrini/feature/tips/ui/intermediate_plan/controller/intermediate_tips_controller.dart';

class IntermediateTipsUi extends StatelessWidget {
  const IntermediateTipsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntermediateTipsController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   elevation: 0,
      //   title: const Text(
      //     'Health Tips',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 20,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      //     onPressed: () => Get.back(),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.search, color: Colors.white),
      //       onPressed: () => _showSearchDialog(context, controller),
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.filter_list, color: Colors.white),
      //       onPressed: () => _showFilterDialog(context, controller),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          // Search Bar
          // _buildSearchBar(controller),
          SizedBox(
            height: 60,
          ),

          // Category Filter Chips
          _buildCategoryFilter(controller),

          // Health Cards List
          Expanded(
            child: _buildHealthCardsList(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(IntermediateTipsController controller) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => controller.setSearchQuery(value),
        decoration: InputDecoration(
          hintText: 'Search health tips...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () => controller.setSearchQuery(''),
                )
              : const SizedBox()),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(IntermediateTipsController controller) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.availableCategories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Obx(() => _buildCategoryChip(
                  controller,
                  'All',
                  null,
                  controller.selectedCategory.value == null,
                ));
          }

          final category = controller.availableCategories[index - 1];
          return Obx(() => _buildCategoryChip(
                controller,
                controller.getCategoryName(category),
                category,
                controller.selectedCategory.value == category,
              ));
        },
      ),
    );
  }

  Widget _buildCategoryChip(
    IntermediateTipsController controller,
    String label,
    HealthType? category,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: normalText(text: label),
        selected: isSelected,
        onSelected: (selected) {
          controller.setCategory(selected ? category : null);
        },
        selectedColor: AppColors.primaryColor,
        // checkmarkColor: AppColors.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.whiteColor : Colors.white,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.whiteColor : Colors.grey[300]!,
        ),
      ),
    );
  }

  Widget _buildHealthCardsList(IntermediateTipsController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        );
      }

      final filteredCards = controller.filteredCards;

      if (filteredCards.isEmpty) {
        return _buildEmptyState();
      }

      return RefreshIndicator(
        onRefresh: () async {
          controller.refreshData();
        },
        color: AppColors.primaryColor,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filteredCards.length,
          itemBuilder: (context, index) {
            final card = filteredCards[index];
            HealthController controller = Get.put(HealthController());
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: HealthCardWidget(
                card: card,
                controller: controller,
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.health_and_safety_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No health tips found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(
      BuildContext context, IntermediateTipsController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Health Tips'),
          content: TextField(
            autofocus: true,
            onChanged: (value) => controller.setSearchQuery(value),
            decoration: const InputDecoration(
              hintText: 'Enter search term...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.setSearchQuery('');
                Navigator.pop(context);
              },
              child: const Text('Clear'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog(
      BuildContext context, IntermediateTipsController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter by Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('All Categories'),
                leading: Radio<HealthType?>(
                  value: null,
                  groupValue: controller.selectedCategory.value,
                  onChanged: (value) {
                    controller.setCategory(value);
                    Navigator.pop(context);
                  },
                ),
              ),
              ...controller.availableCategories.map((category) {
                return ListTile(
                  title: Text(controller.getCategoryName(category)),
                  leading: Radio<HealthType?>(
                    value: category,
                    groupValue: controller.selectedCategory.value,
                    onChanged: (value) {
                      controller.setCategory(value);
                      Navigator.pop(context);
                    },
                  ),
                  trailing: Text(
                    '${controller.getCardCountByCategory(category)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clearFilters();
                Navigator.pop(context);
              },
              child: const Text('Clear All'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
