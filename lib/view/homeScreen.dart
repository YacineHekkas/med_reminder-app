import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled_med/view/MedicineDetailPage.dart';

import '../constant/colors.dart';


// class MedicineTrackerScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Language Selector and Profile Section
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   crossAxisAlignment: CrossAxisAlignment.start,
//               //   children: [
//               //     Container(
//               //       width: 70,
//               //       height: 70,
//               //       decoration: BoxDecoration(
//               //         shape: BoxShape.circle,
//               //         image: DecorationImage(
//               //           image: NetworkImage('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-c09hwKQnOIyNk6GgnFy1rUPR7t6P6E.png'),
//               //           fit: BoxFit.cover,
//               //         ),
//               //       ),
//               //     ),
//               //     LanguageSelector(),
//               //   ],
//               // ),
//               Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       width: 90,
//                       height: 90,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: AssetImage(
//                             'assets/images/avatar.png'
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: LanguageSelector(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Greeting Text
//               Center(
//                 child: Text(
//                   'hello_name'.tr(args: ['']),
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//
//               // Medicines Section Title
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'medicines_for'.tr(),
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     'today'.tr(),
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.orange,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               // Medicine Cards
//               GestureDetector(
//                 onTap: (){
//                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicineDetailPage()));
//                 },
//                 child:MedicineCard(
//                   title: 'next_medicine'.tr(),
//                   subtitle: 'bp_medicine_instruction'.tr(),
//                   color: Color(0xfff4c430),
//                   imgPath: 'assets/images/boite.png',
//
//                 ),
//               ),
//
//
//               const SizedBox(height: 15),
//
//               MedicineCard(
//                 title: 'bactrium_tablets'.tr(),
//                 subtitle: 'bactrium_instruction'.tr(),
//                 color: Color(0xffa8915f),
//                 imgPath: 'assets/images/food.png',
//               ),
//
//               const SizedBox(height: 15),
//
//               MedicineCard(
//                 title: 'ibuprofen_tablets'.tr(),
//                 subtitle: 'ibuprofen_instruction'.tr(),
//                 color: Color(0xffffefca),
//                 imgPath: 'assets/images/plan.png',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class MedicineTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/avatar.png'
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: LanguageSelector(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Center(
                child: Text(
                  'hello_name'.tr(args: ['']),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'medicines_for'.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    'today'.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicineDetailPage()));
                },
                child: MedicineCard(
                  title: 'next_medicine'.tr(),
                  subtitle: 'bp_medicine_instruction'.tr(),
                  color: AppColors.primaryColor,
                  imgPath: 'assets/images/boite.png',
                ),
              ),

              const SizedBox(height: 15),

              MedicineCard(
                title: 'bactrium_tablets'.tr(),
                subtitle: 'bactrium_instruction'.tr(),
                color: AppColors.secondaryColor,
                imgPath: 'assets/images/food.png',
              ),

              const SizedBox(height: 15),

              MedicineCard(
                title: 'ibuprofen_tablets'.tr(),
                subtitle: 'ibuprofen_instruction'.tr(),
                color: AppColors.tertiaryColor,
                imgPath: 'assets/images/plan.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String value) async {
        // Save selected language
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('locale', value);

        // Change app language
        context.setLocale(Locale(value));
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        PopupMenuItem(
          value: 'fr',
          child: Text('Français'),
        ),
        PopupMenuItem(
          value: 'ar',
          child: Text('العربية'),
        ),
      ],
    );
  }
}

// MedicineCard implementation remains the same
class MedicineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String? imgPath;


  const MedicineCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imgPath,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('$imgPath'),
              )
            ],
          ),
        ],
      ),
    );
  }
}