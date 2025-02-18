import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:untitled_med/constant/colors.dart';
import '../controllers/data_controller.dart';
import '../model/advice.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<List<Advice>>(
        future: DataService.getAdvices(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('error_message'.tr(args: [snapshot.error.toString()])));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('no_advice_available'.tr()));
          }

          final advices = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 50.0,
                backgroundColor: AppColors.backgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('health_advices'.tr()),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 40,),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final advice = advices[index];
                    return _buildAdviceItem(context, advice);
                  },
                  childCount: advices.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAdviceItem(BuildContext context, Advice advice) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _showAdviceDialog(context, advice),
        child: Container(
          color: AppColors.tertiaryColor.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    advice.imgPath,
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    advice.illnessName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                    Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAdviceDialog(BuildContext context, Advice advice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(advice.illnessName),
          content: SingleChildScrollView(
            child: ListBody(
              children: advice.advices.map((item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Expanded(child: Text(item)),
                  ],
                ),
              )).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('close'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}