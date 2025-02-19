import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled_med/view/AdviceScreen.dart';
import 'package:untitled_med/view/MedicineDetailPage.dart';

import '../constant/colors.dart';
import '../controllers/alarm_controller.dart';
import 'PlannerMenuScreen.dart';
import 'RecipesScreen.dart';



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

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipesScreen()));
          },
          child:
          MedicineCard(
                title: 'bactrium_tablets'.tr(),
                subtitle: 'bactrium_instruction'.tr(),
                color: AppColors.secondaryColor,
                imgPath: 'assets/images/food.png',
              ),
        ),

              const SizedBox(height: 15),

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdviceScreen()));
          },
          child:
          MedicineCard(
                title: 'ibuprofen_tablets'.tr(),
                subtitle: 'ibuprofen_instruction'.tr(),
                color: AppColors.tertiaryColor,
                imgPath: 'assets/images/plan.png',
              ),
        )
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Adds border radius
      ),
      color: Colors.white, //
      icon: const Icon(Icons.language),
      onSelected: (String value) async {
        // Save selected language
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('locale', value);

        // Change app language
        context.setLocale(Locale(value));

        await AlarmController.updateTranslatedStrings();

      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'en',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center align text
            children: [
              SvgPicture.asset('assets/images/en.svg', width: 24, height: 24),
              SizedBox(width: 10),
              Text('English '),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'fr',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/fr.svg', width: 24, height: 24),
              SizedBox(width: 10),
              Text('Français'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'ar',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/dz.svg', width: 24, height: 24),
              SizedBox(width: 10),
              Text('      العربية'),
            ],
          ),
        ),
      ],    );
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