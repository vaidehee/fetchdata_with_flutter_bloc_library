import 'package:fetchdatawithflutterbloc/bloc/cat_bloc.dart';
import 'package:fetchdatawithflutterbloc/bloc/cat_events.dart';
import 'package:fetchdatawithflutterbloc/bloc/cat_states.dart';
import 'package:fetchdatawithflutterbloc/model/cat_fact_model.dart';
import 'package:fetchdatawithflutterbloc/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatFactsScreen extends StatefulWidget {

  @override
  _CatFactsScreenState createState() => _CatFactsScreenState();
}

class _CatFactsScreenState extends State<CatFactsScreen> {
  CatsBloc _catsBloc;
  Repository _repository=Repository();

  @override
  void initState() {
    super.initState();
    _catsBloc=CatsBloc(repository: _repository);
  }
  @override
  void dispose() {
    super.dispose();
    _catsBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context)=>CatsBloc(repository: _repository),
        child: ListScreen(),
      ),
    );
  }
}

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CatsBloc>(context).add(CatsFetchingEvent());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.8),
        title: Text("Facts of Cats",style: TextStyle(fontSize: 25.0,color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder(
            bloc: BlocProvider.of<CatsBloc>(context),
            builder: (context,state)
            {
              if(state is CatsUninitializedState)
              {
                return _buildUninitialized();
              }
              else if(state is CatsEmptyState)
              {
                return _buildNoDataText();
              }
              else if(state is CatsErrorState)
              {
                return _buildErrorText();
              }
              else if(state is CatsFetchingState)
              {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else
              {
                final stateAsFactsFetchedState = state as CatsFetchedState;
                final catList = stateAsFactsFetchedState.catsData;

                return _buildFactsList(catList);
              }
            },
          )
        ],
      ),
    );
  }

  Expanded _buildUninitialized() {
    return Expanded(
      child: Center(
        child: Text("Uninitialized State", style: TextStyle(fontSize: 22.0,color: Colors.black), textAlign: TextAlign.center,),
      ),
    );
  }

  Expanded _buildNoDataText() {
    return Expanded(
      child: Center(
        child: Text("No Data Available", style: TextStyle(fontSize: 22.0,color: Colors.black), textAlign: TextAlign.center,),
      ),
    );
  }

  Widget _buildErrorText() {
    return Expanded(
      child: Center(
        child: Text("Sorry Something Went wrong", style: TextStyle(fontSize: 22.0,color: Colors.black), textAlign: TextAlign.center,),
      ),
    );
  }

  Widget _buildFactsList(List<Cats> catList) {
    return Expanded(
      child: ListView.separated(
        itemCount: catList.length,
        itemBuilder: (BuildContext context,int index)
        {      Cats catFacts = catList[index];

        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
          margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(child: Text("${(index+1).toString()}")),
                Text(catFacts.text,style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold),),
              ],
            ));
        },
        separatorBuilder: (BuildContext context,int index)=>SizedBox(height: 5.0,),),
    );
  }
}

