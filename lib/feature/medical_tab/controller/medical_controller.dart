import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prettyrini/feature/medical_tab/model/medical_item_model.dart';

enum TabType { hospital, pharmacy, doctor }

class MedicalController extends GetxController {
  var selectedTab = TabType.hospital.obs;
  var medicalItems = <MedicalItem>[].obs;

  // Sample data
  final List<MedicalItem> allItems = [
    // Hospitals
    MedicalItem(
      name: "Johns Hopkins Hospital",
      rating: 4.9,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=300",
      type: "hospital",
    ),
    MedicalItem(
      name: "Cleveland Clinic",
      rating: 4.8,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1551190822-a9333d879b1f?w=300",
      type: "hospital",
    ),
    MedicalItem(
      name: "Toronto General Hospital",
      rating: 4.7,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300",
      type: "hospital",
    ),
    MedicalItem(
      name: "Mount Sinai Hospital",
      rating: 4.6,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=300",
      type: "hospital",
    ),

    // Pharmacies
    MedicalItem(
      name: "CVS Pharmacy",
      rating: 4.5,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1585435557343-3b092031d4c1?w=300",
      type: "pharmacy",
    ),
    MedicalItem(
      name: "Walgreens",
      rating: 4.4,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=300",
      type: "pharmacy",
    ),
    MedicalItem(
      name: "Rite Aid Pharmacy",
      rating: 4.3,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1471864190281-a93a3070b6de?w=300",
      type: "pharmacy",
    ),
    MedicalItem(
      name: "Health Mart Pharmacy",
      rating: 4.6,
      description:
          "Lorem ipsum dolor sit amet consectetur. Accumsan nibh amet dictumst et arcu ac risus molestudae.",
      imageUrl:
          "https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=300",
      type: "pharmacy",
    ),

    // Doctors
    MedicalItem(
      name: "Dr. Sarah Johnson",
      rating: 4.9,
      description:
          "Specialized in cardiology with 15+ years experience. Lorem ipsum dolor sit amet consectetur.",
      imageUrl:
          "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300",
      type: "doctor",
    ),
    MedicalItem(
      name: "Dr. Michael Chen",
      rating: 4.8,
      description:
          "Expert neurologist providing comprehensive care. Lorem ipsum dolor sit amet consectetur.",
      imageUrl:
          "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300",
      type: "doctor",
    ),
    MedicalItem(
      name: "Dr. Emily Rodriguez",
      rating: 4.7,
      description:
          "Pediatric specialist with excellent patient care. Lorem ipsum dolor sit amet consectetur.",
      imageUrl:
          "https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=300",
      type: "doctor",
    ),
    MedicalItem(
      name: "Dr. James Wilson",
      rating: 4.8,
      description:
          "Orthopedic surgeon with modern treatment approaches. Lorem ipsum dolor sit amet consectetur.",
      imageUrl:
          "https://images.unsplash.com/photo-1651008376811-b90baee60c1f?w=300",
      type: "doctor",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    updateList();
  }

  void changeTab(TabType tabType) {
    selectedTab.value = tabType;
    updateList();
  }

  void updateList() {
    String filterType;
    switch (selectedTab.value) {
      case TabType.hospital:
        filterType = 'hospital';
        break;
      case TabType.pharmacy:
        filterType = 'pharmacy';
        break;
      case TabType.doctor:
        filterType = 'doctor';
        break;
    }

    medicalItems.value =
        allItems.where((item) => item.type == filterType).toList();
  }
}
