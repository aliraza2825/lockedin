import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  //TODO: Implement ContactUsController

  TextEditingController messageCtrl=TextEditingController();
  final ExpansionTileController firstQuestion = ExpansionTileController();
  final ExpansionTileController secondQuestion = ExpansionTileController();
  final ExpansionTileController thirdQuestion = ExpansionTileController();
  final ExpansionTileController fourthQuestion = ExpansionTileController();
  final ExpansionTileController fifthQuestion = ExpansionTileController();

 String ans1='THis is the answer of the first question. please ask this question from the chatbot of the app';
 List<Map<String, dynamic>> faqs=[];
  @override
  void onInit() {
    faqs=[
      {
        'ctrl':firstQuestion,
        'question':'How do I source tools?',
        'answer':"Once you’ve selected a project, DIY MAX will generate a list of required tools and supplies. You can choose to source items directly from partnered vendors within the app. Simply select the items you need, and you’ll be directed to vendors for purchase or rental options."
      },{
        'ctrl':secondQuestion,
        'question':'Can I compare vendor prices?',
        'answer':"Yes, DIY MAX allows you to compare prices from various vendors. When viewing a required tool or supply, you’ll see options from different vendors, along with their prices, availability, and delivery times."
      },{
        'ctrl':thirdQuestion,
        'question':'Are the vendors reliable?',
        'answer':"DIY MAX partners with verified vendors to ensure quality and reliability. You can also check vendor ratings and reviews left by other users to make informed decisions before purchasing or renting tools."
      },{
        'ctrl':fourthQuestion,
        'question':'What if tools are unavailable?',
        'answer':"If a vendor is out of stock, DIY MAX will recommend alternative vendors or similar products. You can also set notifications to be alerted when the item is back in stock or look into renting from other users nearby."
      },{
        'ctrl':fifthQuestion,
        'question':'Can I return or exchange tools?',
        'answer':"Yes, DIY MAX offers return and exchange policies in partnership with the vendors. The return policy will vary depending on the vendor, so be sure to check the specific vendor’s terms before completing your purchase."
      },
    ];
    super.onInit();
  }


}
