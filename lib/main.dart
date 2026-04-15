import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final TextEditingController myItemController = TextEditingController();
  List<String> fruits = [];

  int? editIndex;

  void addOrEditItem() {
    if(myItemController.text.isEmpty) return;

    setState(() {
      if(editIndex != null){
        fruits[editIndex!] = myItemController.text;
        myItemController.clear();
        editIndex = null;
      }
      else{
        fruits.add(myItemController.text);
        myItemController.clear();
      }

    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Simple List Input", style: TextStyle(fontSize: 24),),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: myItemController,
              //keyboardType: ,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fastfood_rounded),
                labelText: "Enter Fruit Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: addOrEditItem,
                  child: Text(
                    editIndex == null? "Add Item" : "Update",
                    style: TextStyle(fontSize: 18),)),
            ),

            SizedBox(height: 20,),

            Expanded(
              child: ListView.builder(
                itemCount: fruits.length,
                itemBuilder: (context , index){
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.arrow_right),
                      title: Text(fruits[index], ),

                      trailing: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            //EDIT
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: (){
                                  setState(() {
                                    editIndex = index;
                                    myItemController.text = fruits[index];
                                  });
                                }
                            ),

                            //DELETE
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  setState(() {
                                    fruits.removeAt(index);
                                  });
                                }
                            ),

                          ],
                        ),
                      ),

                      onTap: (){

                      },

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

