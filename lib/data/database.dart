import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {

  List todos = [];

  // box ref
  final _mybox = Hive.box('mybox');

  //initial data on first time
  void createInitData(){
    todos = [
      ["Les tâches effectuées sont rayées", "personnel", true],
      ["Pour supprimer, glisse vers la gauche", "personnel", false],
      ["Voici ma liste des tâches", "personnel", false],
    ];
  }

  //categories count
  int countItems(String categorie, List list){
    int i, nbr = 0;
    for(i=0;i<list.length;i++){
      if(list[i][1] == categorie){
        nbr++;
      }
    }
    return nbr;
  }

  //load data
  void loadData(){
    todos = _mybox.get("TODOLIST");
  }

  //update data
  void updateData(){
    _mybox.put("TODOLIST", todos);
  }

}