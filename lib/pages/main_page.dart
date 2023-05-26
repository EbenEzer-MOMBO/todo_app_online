import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_sync/components/custom_colors.dart';
import 'package:todo_app_sync/components/large_button.dart';
import 'package:todo_app_sync/components/pad_button.dart';
import 'package:todo_app_sync/data/database.dart';

class MainPage extends StatefulWidget {
  final String surname; // Add this line

  const MainPage({Key? key, required this.surname}) : super(key: key); // Modify the constructor

  @override
  State<MainPage> createState() => _MainPageState();
}

const List<String> _options = [
  'personnel',
  'important',
];

class _MainPageState extends State<MainPage> {
  String _surname = '';
  //hive box
  final _mybox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    _surname = widget.surname;
    //if fisrt time, default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  String _selectedOption = _options.first;

  late String input;


  //ajouter une tâche
  void addTask() {
    showDialog(
        context: context,
        builder: (context) {
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
                    border: OutlineInputBorder(), hintText: "ma tâche ..."),
                onChanged: (String value) {
                  input = value;
                },
              ),
              actions: <Widget>[
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return DropdownButton<String>(
                      value: _selectedOption,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                      items: _options.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    );
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
                      db.todos.add([input, _selectedOption, false]);
                    });
                    db.updateData();
                    //print(db.todos);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Valider"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Annuler",
                    style: TextStyle(color: CustomColors.primaryColor),
                  ),
                ),
              ],
            ),
          );
        });
  }

  //checkbox
  void checkBoxTap(bool? value, int index) {
    setState(() {
      db.todos[index][2] = !db.todos[index][2];
    });
    db.updateData();
  }

  //delete task
  void deleteItem(int index) {
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
    //screen size
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.bgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screen.height * 0.05,
              ),

              //menu, barre recherche, astuces
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: CustomColors.primaryColor,
                          size: 35,
                        )),
                    const Spacer(),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.notifications,
                    //     color: CustomColors.primaryColor,
                    //     size: 35,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: signUserOut,
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: CustomColors.primaryColor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //quoi d'neuf
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Quoi d'neuf, $_surname !",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

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

              const SizedBox(
                height: 10,
              ),

              //horizontal scroll
              SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //bouton
                    PadButton(
                        nbrtask: db.countItems("personnel", db.todos),
                        category: "Personnel"),
                    //bouton
                    PadButton(
                        nbrtask: db.countItems("important", db.todos),
                        category: "Important"),
                    //bouton
                    PadButton(
                        nbrtask: db.countItems("sync", db.todos),
                        category: "Synchro"),
                  ],
                ),
              ),

              SizedBox(
                height: screen.height * 0.01,
              ),

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

              SizedBox(
                height: screen.height * 0.01,
              ),

              Stack(
                children: [
                  SizedBox(
                    height: screen.height * 0.5,
                    width: screen.width * 0.9,
                    child: ListView.builder(
                      itemCount: db.todos.length,
                      itemBuilder: (context, index) {
                        final reversedIndex = db.todos.length -
                            index -
                            1; // calculate the reversed index
                        return LargeButton(
                          task: db.todos[reversedIndex]
                              [0], // access the item with the reversed index
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
                  ),
                ],
              )

              //bouton ajouter
            ],
          ),
        ),
      ),
    );
  }
}
