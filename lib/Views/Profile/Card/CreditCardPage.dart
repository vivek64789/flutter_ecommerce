import 'package:e_commers/Data/ListCard.dart';
import 'package:e_commers/Helpers/Colors.dart';
import 'package:e_commers/Views/Profile/Card/AddCard.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreditCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(
            text: 'My Cards', color: primaryColor, fontWeight: FontWeight.w600),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.add_circle_outline_rounded,
                    color: primaryColor, size: 17),
                SizedBox(width: 5.0),
                GestureDetector(
                  child: CustomText(
                      text: 'Add Card', color: primaryColor, fontSize: 15),
                  onTap: () => Navigator.of(context).push(customRoute(
                      page: AddCreditCardPage(), curved: Curves.easeInOut)),
                ),
                SizedBox(width: 7.0),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                controller: PageController(viewportFraction: .9),
                physics: BouncingScrollPhysics(),
                itemCount: cards.length,
                itemBuilder: (_, i) {
                  final card = cards[i];

                  return _CreditCard(
                    cardHolderName: card.cardHolderName,
                    cardNumber: card.cardNumber,
                    expiryDate: card.expiracyDate,
                    cvvCode: card.cvv,
                    brand: card.brand,
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            CustomText(text: 'Last movements', fontSize: 19),
            SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String brand;

  const _CreditCard(
      {this.cardNumber,
      this.expiryDate,
      this.cardHolderName,
      this.cvvCode,
      this.brand});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      margin: EdgeInsets.only(right: 15.0),
      height: 220,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Color(0xFF3A4960)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('Assets/card-chip.png', height: 60),
              SvgPicture.asset('Assets/$brand.svg', height: 80)
            ],
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: CustomText(
                text: cardNumber,
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: cardHolderName, fontSize: 23, color: Colors.white),
                CustomText(text: expiryDate, color: Colors.white, fontSize: 19),
              ],
            ),
          )
        ],
      ),
    );
  }
}
