import 'dart:developer';

import 'package:fetchdatawithflutterbloc/model/cat_fact_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class CateDataProvider
{
  String baseUrl = "https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=50";
  final successCode = 200;

   Future<List<Cats>> fetchCatFacts() async
   {
     final response=await http.get(baseUrl);
     return parseResponse(response);
   }

   //this method parses the data fetched from internet
   List<Cats> parseResponse(http.Response response) {
     final responseData=jsonDecode(response.body);
     if(response.statusCode==successCode)
       {
         List<Cats> catList;
         catList=(responseData as List).map((i) => Cats.fromJson(i)).toList();
         return catList;
       }
     else
       {
         throw Exception('failed to load List');
       }
 }

}