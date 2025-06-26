import 'package:flutter/material.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';

class HeartRateCard extends StatelessWidget {
  final int heartRate;
  final String time;
  final VoidCallback? onTap;
  final String heading;
  final String value;
  final String unit;
  final IconData icon;
  final Color iconColor;
  final bool isTimeVisible;
  final Color textColor;
  final Color cardColor;

  const HeartRateCard({
    Key? key,
    required this.heartRate,
    required this.time,
    this.onTap,
    required this.heading,
    required this.value,
    required this.unit,
    required this.icon,
    required this.iconColor,
    required this.isTimeVisible,
    this.textColor = Colors.white,
    this.cardColor = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: cardColor == Colors.white
                    ? AppColors.primaryColor.withOpacity(0.1)
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 16,
              ),
            ),
            const SizedBox(height: 12),

            // Heading
            Text(
              heading,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),

            // Value and Unit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      unit,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (isTimeVisible) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time,
                            size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),

            // Time (if visible)
          ],
        ),
      ),
    );
  }
}

// class HeartRateCard extends StatelessWidget {
//   final int heartRate;
//   final String time;
//   final VoidCallback? onTap;
//   final String heading;
//   final String value;
//   final String unit;
//   final IconData icon;
//   final Color iconColor;
//   final bool isTimeVisible;
//   final Color textColor;
//   final Color cardColor;

//   HeartRateCard({
//     Key? key,
//     required this.heartRate,
//     required this.time,
//     this.onTap,
//     required this.heading,
//     required this.value,
//     required this.unit,
//     required this.icon,
//     required this.iconColor,
//     required this.isTimeVisible,
//     this.textColor = Colors.white,
//     this.cardColor = AppColors.primaryColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(16),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16), color: cardColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: iconColor,
//                     size: 15,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 smallText(
//                   text: heading,
//                   color: textColor,
//                 ),
//                 const SizedBox(width: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         headingText(
//                             text: '$value ',
//                             color: textColor,
//                             fontWeight: FontWeight.bold),
//                         smallText(text: unit, color: textColor)
//                       ],
//                     ),
//                     isTimeVisible
//                         ? Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.timer),
//                                 Text(
//                                   time,
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
