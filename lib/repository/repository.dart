import 'package:fetchdatawithflutterbloc/data_providers/cat_data_provider.dart';
import 'package:fetchdatawithflutterbloc/model/cat_fact_model.dart';

class Repository
{
  CateDataProvider cateDataProvider = new CateDataProvider();
  Future <List<Cats>> fetchCatsFromProvide()
  {
    return cateDataProvider.fetchCatFacts();
  }
}