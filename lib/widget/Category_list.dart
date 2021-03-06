import 'package:ecommerce_app/constant/Constants.dart';
import 'package:ecommerce_app/widget/ResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category_list extends StatelessWidget {
  const Category_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 5.w),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ResultScreen(query: categoriesList[index])));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(categoryLogos[index]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Text(categoriesList[index]),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
