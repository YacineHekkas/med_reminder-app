// lib/pages/medicine_detail_page.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constant/colors.dart';
import '../widgets/schedule_editor_dialog.dart';

// class MedicineDetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Your Medicine',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//
//               // Pill Image
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//
//                 children: [
//                   Center(
//                     child: Container(
//
//                       child: Stack(
//                         children: [
//                           Image.asset(
//                             "assets/images/pill.png",
//                             width: 190,
//                             height: 190,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//
//                   // Medicine Name
//                   Text(
//                     'Antihistamine',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//
//                   // Description
//                   Text(
//                     'Antihistamines are medications commonly used to relieve symptoms of allergies, such as fever, rash, conjunctivitis, or allergic reactions to insect bites or stings.',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                       height: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Timing Tags
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Color(0xfff4c430).withOpacity(0.6),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             'After Breakfast',
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Color(0xffa8915f).withOpacity(0.6),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             'After lunch',
//                             style: TextStyle(
//                               color: Colors.brown,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.teal.shade50,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             'After Dinner',
//                             style: TextStyle(
//                               color: Colors.teal,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 30),
//
//                   // Info Grid
//                   Row(
//                     children: [
//                       Expanded(
//                         child: InfoItem(
//                           icon: Icons.access_time,
//                           title: 'Amount',
//                           value: '3 pills/day',
//                           iconColor: Colors.blue,
//                         ),
//                       ),
//                       Expanded(
//                         child: InfoItem(
//                           icon: Icons.calendar_today,
//                           title: 'Month',
//                           value: '14/31 taken',
//                           iconColor: Colors.pink,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: InfoItem(
//                           icon: Icons.medical_services_outlined,
//                           title: 'Cause',
//                           value: '',
//                           iconColor: Colors.purple,
//                         ),
//                       ),
//                       Expanded(
//                         child: InfoItem(
//                           icon: Icons.medication_outlined,
//                           title: 'Cap Size',
//                           value: '',
//                           iconColor: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                 ],
//               ),
//
//               // Bottom Buttons
//               Row(
//                 children: [
//
//                   Expanded(
//                     child: // In your MedicineDetailPage class, update the Edit Schedule button:
//
//                     ElevatedButton(
//                       onPressed: () async {
//                         final result = await showDialog(
//                           context: context,
//                           builder: (context) => ScheduleEditorDialog(
//                             medicineName: 'Antihistamine',
//                             initialTimes: null, // Pass saved times here if available
//                           ),
//                         );
//
//                         if (result != null) {
//                           // Handle the updated schedules
//                           // You might want to update your UI or state here
//                         }
//                       },
//                       child: Text('Edit Schedule',
//                       style: TextStyle(color: Colors.black),),
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         backgroundColor: Color(0xfff4c430),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class InfoItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;
//   final Color iconColor;
//
//   const InfoItem({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.value,
//     required this.iconColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, color: iconColor, size: 20),
//             SizedBox(width: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 4),
//         Text(
//           value.isNotEmpty ? value : '-',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
class MedicineDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'your_medicine'.tr(),
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/pill.png",
                            width: 190,
                            height: 190,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'antihistamine'.tr(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'antihistamine_description'.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.subtitleColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TimingTag(
                          text: 'after_breakfast'.tr(),
                          color: AppColors.primaryColor,
                          textColor: Colors.orange,
                        ),
                        SizedBox(width: 10),
                        TimingTag(
                          text: 'after_lunch'.tr(),
                          color: AppColors.secondaryColor,
                          textColor: Colors.brown,
                        ),
                        SizedBox(width: 10),
                        TimingTag(
                          text: 'after_dinner'.tr(),
                          color: Colors.teal.shade50,
                          textColor: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: InfoItem(
                          icon: Icons.access_time,
                          title: 'amount'.tr(),
                          value: '3_pills_per_day'.tr(),
                          iconColor: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: InfoItem(
                          icon: Icons.calendar_today,
                          title: 'month'.tr(),
                          value: '14_31_taken'.tr(),
                          iconColor: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InfoItem(
                          icon: Icons.medical_services_outlined,
                          title: 'cause'.tr(),
                          value: '',
                          iconColor: Colors.purple,
                        ),
                      ),
                      Expanded(
                        child: InfoItem(
                          icon: Icons.medication_outlined,
                          title: 'cap_size'.tr(),
                          value: '',
                          iconColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (context) => ScheduleEditorDialog(
                            medicineName: 'antihistamine'.tr(),
                            initialTimes: null,
                          ),
                        );

                        if (result != null) {
                          // Handle the updated schedules
                        }
                      },
                      child: Text(
                        'edit_schedule'.tr(),
                        style: TextStyle(color: AppColors.textColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimingTag extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const TimingTag({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const InfoItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: AppColors.subtitleColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value.isNotEmpty ? value : '-',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
