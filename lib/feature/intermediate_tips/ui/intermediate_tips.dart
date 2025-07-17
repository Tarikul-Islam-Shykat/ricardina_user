import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/common_page/model/health_card_model.dart';
import 'package:prettyrini/feature/intermediate_tips/controller/tips_controller.dart';
import 'package:prettyrini/feature/intermediate_tips/widget/tips_widget_card.dart';

class IntermediateTipsUI extends StatefulWidget {
  const IntermediateTipsUI({Key? key}) : super(key: key);

  @override
  State<IntermediateTipsUI> createState() => _IntermediateTipsUIScreenState();
}

class _IntermediateTipsUIScreenState extends State<IntermediateTipsUI> {
  final TipsController controller = Get.put(TipsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildCategoryFilter(),
            const SizedBox(height: 20),
            _buildTipsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          headingText(text: "Health Tips"),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: HealthType.values.length + 1, // +1 for "All" option
        itemBuilder: (context, index) {
          if (index == 0) {
            // "All" option
            return Obx(() => _buildCategoryChip(
                  label: "All",
                  isSelected: controller.selectedType == null,
                  onTap: () => controller.filterByType(null),
                  color: const Color(0xFF34495E),
                  icon: Icons.apps,
                ));
          }

          final type = HealthType.values[index - 1];
          return Obx(() => _buildCategoryChip(
                label: _getTypeDisplayName(type),
                isSelected: controller.selectedType == type,
                onTap: () => controller.filterByType(type),
                color: controller.getTypeColor(type),
                icon: controller.getTypeIcon(type),
              ));
        },
      ),
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsList() {
    return Obx(() {
      if (controller.isLoading) {
        return const Padding(
          padding: EdgeInsets.all(50.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2C3E50)),
          ),
        );
      }

      if (controller.filteredCards.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(50.0),
          child: Text(
            'No health cards found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: controller.filteredCards
              .map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TipsCardWidget(
                      card: card,
                      controller: controller,
                    ),
                  ))
              .toList(),
        ),
      );
    });
  }

  String _getTypeDisplayName(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return "Heart";
      case HealthType.blood:
        return "Blood";
      case HealthType.water:
        return "Water";
      case HealthType.step:
        return "Steps";
      case HealthType.weight:
        return "Weight";
      case HealthType.health:
        return "Health";
      default:
        return "Health";
    }
  }
}
