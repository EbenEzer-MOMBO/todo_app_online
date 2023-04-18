import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_sync/components/custom_colors.dart';
import 'package:todo_app_sync/components/large_button.dart';
import 'package:todo_app_sync/components/pad_button.dart';
import 'package:todo_app_sync/data/database.dart';
import 'package:todo_app_sync/pages/params_page.dart';

class MainPage extends StatefulWidget{
  const MainPage ({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  //hive box
  final _mybox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    //if fisrt time, default data
    if(_mybox.get("TODOLIST") == null){
      db.createInitData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  late String _selectedOption = _options[0];
  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];
  late String input;

  //ajouter une tâche
  void addTask(){
    showDialog(
        context: context,
        builder: (context){
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: Colors.white,
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Text("Ajouter une tâche"),
              content: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "ma tâche ..."
                ),
                onChanged: (String value) {
                  input = value;
                },
              ),
              actions: <Widget>[
                DropdownButton(
                  value: _selectedOption,
                  items: _options.map((String option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                    });
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      CustomColors.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      db.todos.add([input, "cat", false]);
                    });
                    db.updateData();
                    //print(db.todos);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Valider"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Annuler", style: TextStyle(color: CustomColors.primaryColor),),
                ),
              ],
            ),
          );
        }
        );
  }

  //checkbox
  void checkBoxTap(bool? value, int index){
    setState(() {
      db.todos[index][2] = !db.todos[index][2];
    });
    db.updateData();
  }

  //delete task
  void deleteItem(int index){
    setState(() {
      db.todos.removeAt(index);
    });
    db.updateData();
  }

  //deconnexion method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bgColor,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 55,),

            //menu, barre recherche, astuces
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: signUserOut,
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: CustomColors.primaryColor,
                      size: 35,)
                  ),
                  const Spacer(),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.search,
                  //       color: CustomColors.primaryColor,
                  //       size: 35,)
                  // ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        color: CustomColors.primaryColor,
                        size: 35,
                      ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: CustomColors.primaryColor,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            //quoi d'neuf
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Quoi d'neuf, Eben !",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25,),

            //categories
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Catégories",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10,),

            //horizontal scroll
            SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //bouton
                  PadButton(nbrtask: db.countItems("cat", db.todos), category: "Personnel"),
                  //bouton
                  PadButton(nbrtask: 2, category: "Important"),
                  //bouton
                  PadButton(nbrtask: 2, category: "Classe"),
                  //bouton
                  PadButton(nbrtask: 2, category: "Important"),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            //taches du jour
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Tâches du jour",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20,),

            Stack(
              children: [
                SizedBox(
                  height: 390,
                  width: 360,
                  child: ListView.builder(
                    itemCount: db.todos.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = db.todos.length - index - 1; // calculate the reversed index
                      return LargeButton(
                        task: db.todos[reversedIndex][0], // access the item with the reversed index
                        isCompleted: db.todos[reversedIndex][2],
                        onChanged: (value) => checkBoxTap(value, reversedIndex),
                        deleteTask: (context) => deleteItem(reversedIndex),
                      );
                    },
                  ),
                ),

                // bouton ajout
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purpleAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: addTask,
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ),
                )
                ,
              ],
            )


            //bouton ajouter


            ],

        ),
      ),
    );
  }
}