// lib/pages/medicine_detail_page.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/schedule_editor_dialog.dart';

class MedicineDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Your Medicine',
          style: TextStyle(
            color: Colors.black,
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

              // Pill Image
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

                  // Medicine Name
                  Text(
                    'Antihistamine',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Description
                  Text(
                    'Antihistamines are medications commonly used to relieve symptoms of allergies, such as fever, rash, conjunctivitis, or allergic reactions to insect bites or stings.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Timing Tags
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xfff4c430).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'After Breakfast',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xffa8915f).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'After lunch',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'After Dinner',
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Info Grid
                  Row(
                    children: [
                      Expanded(
                        child: InfoItem(
                          icon: Icons.access_time,
                          title: 'Amount',
                          value: '3 pills/day',
                          iconColor: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: InfoItem(
                          icon: Icons.calendar_today,
                          title: 'Month',
                          value: '14/31 taken',
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
                          title: 'Cause',
                          value: '',
                          iconColor: Colors.purple,
                        ),
                      ),
                      Expanded(
                        child: InfoItem(
                          icon: Icons.medication_outlined,
                          title: 'Cap Size',
                          value: '',
                          iconColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),

              // Bottom Buttons
              Row(
                children: [

                  Expanded(
                    child: // In your MedicineDetailPage class, update the Edit Schedule button:

                    ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (context) => ScheduleEditorDialog(
                            medicineName: 'Antihistamine',
                            initialTimes: null, // Pass saved times here if available
                          ),
                        );

                        if (result != null) {
                          // Handle the updated schedules
                          // You might want to update your UI or state here
                        }
                      },
                      child: Text('Edit Schedule',
                      style: TextStyle(color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color(0xfff4c430),
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
                color: Colors.grey[600],
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
          ),
        ),
      ],
    );
  }
}