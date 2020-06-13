import 'package:fetchdatawithflutterbloc/model/cat_fact_model.dart';
import 'package:fetchdatawithflutterbloc/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cat_events.dart';
import 'cat_states.dart';

class CatsBloc extends Bloc<CatsFetchingEvent,CatsListingState>
{
  Repository repository=new Repository();
  CatsBloc({this.repository}) : assert(repository != null);

  @override
  CatsListingState get initialState => CatsUninitializedState();

  @override
  Stream<CatsListingState> mapEventToState(CatsFetchingEvent event) async* {
    yield CatsFetchingState();
    List<Cats> catList;
    try {
      if(event is CatsFetchingEvent)
        {
          catList = await repository.fetchCatsFromProvide();
        }
      if (catList.length == 0) {
        yield CatsEmptyState();
      } else {
        yield CatsFetchedState(catsData: catList);
      }
    } catch (_) {
      yield CatsErrorState();
    }
  }
}