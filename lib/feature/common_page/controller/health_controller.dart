import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/common_page/model/health_card_model.dart';

class HealthController extends GetxController {
  // Observable list of health cards
  final RxList<HealthCard> _healthCards = <HealthCard>[].obs;
  final RxList<HealthCard> _filteredCards = <HealthCard>[].obs;
  final Rx<HealthType?> _selectedType = Rx<HealthType?>(null);
  final RxBool _isLoading = false.obs;

  // Getters
  List<HealthCard> get healthCards => _healthCards;
  List<HealthCard> get filteredCards => _filteredCards;
  HealthType? get selectedType => _selectedType.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadHealthCards();
  }

  // Load health cards data
  void loadHealthCards() {
    _isLoading.value = true;

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _healthCards.value = HealthData.getHealthCards();
      _filteredCards.value = _healthCards;
      _isLoading.value = false;
    });
  }

  // Filter cards by type
  void filterByType(HealthType? type) {
    _selectedType.value = type;

    if (type == null) {
      _filteredCards.value = _healthCards;
    } else {
      _filteredCards.value =
          _healthCards.where((card) => card.type == type).toList();
    }
  }

  // Get cards by specific type
  List<HealthCard> getCardsByType(HealthType type) {
    return _healthCards.where((card) => card.type == type).toList();
  }

  // Get type color
  Color getTypeColor(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return const Color(0xFFE74C3C);
      case HealthType.blood:
        return const Color(0xFFE55353);
      case HealthType.water:
        return const Color(0xFF3498DB);
      case HealthType.step:
        return const Color(0xFF2ECC71);
      case HealthType.weight:
        return const Color(0xFFE67E22);
      case HealthType.health:
        return const Color(0xFF9B59B6);
      default:
        return const Color(0xFF34495E);
    }
  }

  // Get type icon
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
      default:
        return Icons.health_and_safety;
    }
  }

  // Search functionality
  void searchCards(String query) {
    if (query.isEmpty) {
      filterByType(_selectedType.value);
      return;
    }

    final searchResults = _healthCards.where((card) {
      return card.title.toLowerCase().contains(query.toLowerCase()) ||
          card.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    _filteredCards.value = searchResults;
  }

  // Refresh data
  void refreshData() {
    loadHealthCards();
  }

  // calender

  var selectedDate = DateTime.now().obs;
  var currentMonth = DateTime.now().obs;
  var heartRate = 120.obs;
  var measurementTime = "08:00am".obs;

  List<DateTime> get monthDates {
    final firstDay =
        DateTime(currentMonth.value.year, currentMonth.value.month, 1);
    final lastDay =
        DateTime(currentMonth.value.year, currentMonth.value.month + 1, 0);

    List<DateTime> dates = [];
    for (int i = 0; i < lastDay.day; i++) {
      dates.add(firstDay.add(Duration(days: i)));
    }
    return dates;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    // Here you can add logic to fetch heart rate data for selected date
    // For demo purposes, we'll just update with random values
    heartRate.value = 115 + (date.day % 20);
    measurementTime.value =
        "${8 + (date.day % 4)}:${(date.day % 6) * 10}${date.day % 2 == 0 ? 'am' : 'pm'}";
  }

  void changeMonth(int monthOffset) {
    currentMonth.value = DateTime(
        currentMonth.value.year, currentMonth.value.month + monthOffset, 1);

    // If selected date is not in current month, select first day of new month
    if (selectedDate.value.month != currentMonth.value.month ||
        selectedDate.value.year != currentMonth.value.year) {
      selectDate(currentMonth.value);
    }
  }
}
