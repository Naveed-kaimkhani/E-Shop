import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Models/ReviewModel.dart';
import 'package:ecommerce_app/Provider/UserDetailsProvider.dart';
import 'package:ecommerce_app/resources/Firestore_methods.dart';
import 'package:ecommerce_app/widget/Add_removeItemButton.dart';
import 'package:ecommerce_app/widget/ReviewWidget.dart';
import 'package:ecommerce_app/widget/SliderPay_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../Models/Product.dart';
import '../constant/Utils.dart';
import '../widget/LoadingWidget.dart';
import '../widget/RatingDialogueWidget.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils.getScreenSize();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: Container(
            margin: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                'assets/images/back.svg',
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/cart.svg'),
              iconSize: 25,
              color: Colors.black,
            ),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/images/search.svg')),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: screenSize.height * 0.3),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26)),
                    ),
                    height: screenSize.height * 0.6,
                    width: screenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: (screenSize.width * 0.2),
                              left: (screenSize.width * 0.03)),
                          child: SizedBox(
                            height: screenSize.height / 7,
                            width: screenSize.width,
                            child: Text(
                              product.description,
                              // maxLines: 6,
                              //overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
                                //fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.03),
                          child: Row(
                            children: [
                              Add_removeItemButton(
                                  icon: Icons.remove, press: () {}),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  product.price.toString().padLeft(2, "0"),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              Add_removeItemButton(
                                  icon: Icons.add, press: () {}),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // showBottomSheet(context: context, builder: builder)
                                  showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      //  barrierColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30)),
                                      ),
                                      context: context,
                                      builder: (context) => StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection("products").doc(product.uid).collection("review").snapshots(),
                                            builder:(context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
                                          if(snapshot.connectionState==ConnectionState.waiting)return LoadingWidget();
                                          else  {
                                            return   ListView.builder(
                                          
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                         ReviewModel review= ReviewModel.fromJson(snapshot.data!.docs[index].data());
                                          
                                          return ReviewWidget(review: review);
                                          }
                                          );
                                                      }
        }
        
         ,)
                                  );
                                },
                                child: const Text("Reviews")),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          RatingDialogueWidget(productuid: product.uid,));
                                },
                                child: Text("Drop your review"))
                          ],
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                    // color: product.color,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color:Colors.black,
                                    )),
                                child: IconButton(
                                  onPressed: () async{
                                await Firestore_method.AddToCart(product: product);
                                    Utils.showSnackBar(context: context, content:"Added to cart");
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/images/add_to_cart.svg",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: screenSize.height * 0.08,
                                  width: screenSize.width * 0.7,
                                  child: SlideAction(
      borderRadius: 12,
      innerColor: Color.fromARGB(255, 8, 92, 160),
      outerColor: Colors.blue,
      sliderButtonIcon: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.white,
      ),
      text: "Slide to pay",
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        //fontWeight: FontWeight.bold,
      ),
      sliderRotate: false,
      onSubmit:()async{
        await Firestore_method.addProductsToOrders(product: product,user: Provider.of<UserDetailsProvider>(context,listen: false).userDetails,);     
      },
    )
    ),
                ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          product.ProductName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(text: "Price\n"),
                                TextSpan(
                                    text: product.price.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                    )),
                              ]),
                            ),
                          ),
                          Expanded(
                            child: Image.network(
                                "http://www.pngall.com/wp-content/uploads/2/Bag-PNG.png"),
                          )
                        ],
                      )
                    ],
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
