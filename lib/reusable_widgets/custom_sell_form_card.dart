import 'package:campus_sell/reusable_widgets/constants.dart';
import 'package:campus_sell/reusable_widgets/custom_form_lable.dart';
import 'package:flutter/material.dart';

import 'custom_forms.dart';

class CustomSellFormCard extends StatelessWidget {
  const CustomSellFormCard({super.key});

  @override
  Widget build(BuildContext context) {
      TextEditingController itemTypeController = TextEditingController();

    return   IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(left: 30,right: 30),
        color: const Color(0xFFFFFFFf),
        child: ClipRRect(
          
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomFormLable(textLable: "Product Name*:"),
              NameForm(),
              const CustomFormLable(textLable: "Product Description*:"),
                 DescriptionForm(),
              const CustomFormLable(textLable: "Product Type*:"),
                  CustomDropdownButtonFormField(itemTypeController: itemTypeController,
                  items: productTypes,),
              const CustomFormLable(textLable: "Product Price*:"),
                 PriceForm(),
                  
            ],
          ),
        ),
      ),
    );
  }
}