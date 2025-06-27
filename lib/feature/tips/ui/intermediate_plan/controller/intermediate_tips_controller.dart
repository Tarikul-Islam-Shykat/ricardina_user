import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/common_page/model/health_card_model.dart';

class IntermediateTipsController extends GetxController {
  // Observable list of health cards
  var healthCards = <HealthCard>[].obs;
  
  // Observable selected category filter
  var selectedCategory = Rx<HealthType?>(null);
  
  // Observable search query
  var searchQuery = ''.obs;
  
  // Observable loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadHealthCards();
  }

  // Load health cards from data source
  void loadHealthCards() {
    isLoading(true);
    try {
      healthCards.value = HealthData.getHealthCards();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load health tips',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  // Get filtered health cards based on category and search
  List<HealthCard> get filteredCards {
    var cards = healthCards.value;
    
    // Filter by category if selected
    if (selectedCategory.value != null) {
      cards = cards.where((card) => card.type == selectedCategory.value).toList();
    }
    
    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      cards = cards.where((card) =>
          card.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          card.description.toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    }
    
    return cards;
  }

  // Set category filter
  void setCategory(HealthType? category) {
    selectedCategory.value = category;
  }

  // Set search query
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Clear all filters
  void clearFilters() {
    selectedCategory.value = null;
    searchQuery.value = '';
  }

  // Get icon for health type
  IconData getTypeIcon(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return Icons.favorite;
      case HealthType.blood:
        return Icons.bloodtype;
      case HealthType.water:
        return Icons.water_drop;
      case HealthType.step:
        return Icons.directions_walk;
      case HealthType.weight:
        return Icons.monitor_weight;
      case HealthType.health:
        return Icons.health_and_safety;
    }
  }

  // Get color for health type
  Color getTypeColor(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return Colors.red;
      case HealthType.blood:
        return Colors.deepOrange;
      case HealthType.water:
        return Colors.blue;
      case HealthType.step:
        return Colors.green;
      case HealthType.weight:
        return Colors.purple;
      case HealthType.health:
        return Colors.teal;
    }
  }

  // Get category display name
  String getCategoryName(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return 'Heart';
      case HealthType.blood:
        return 'Blood';
      case HealthType.water:
        return 'Hydration';
      case HealthType.step:
        return 'Activity';
      case HealthType.weight:
        return 'Weight';
      case HealthType.health:
        return 'Wellness';
    }
  }

  // Get all available categories
  List<HealthType> get availableCategories {
    return HealthType.values;
  }

  // Get cards count by category
  int getCardCountByCategory(HealthType type) {
    return healthCards.where((card) => card.type == type).length;
  }

  // Refresh data
  void refreshData() {
    loadHealthCards();
  }
}