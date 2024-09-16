import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'List View',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final List<String> items = List<String>.generate(20, (i) => '$i');

  TextEditingController text1 = TextEditingController();
  List<String> mydata = <String>['Kalpesh'];
  var olddata;
  String textdemo =
      'Hello this is sub title of the list tile click on this listtile and show more details';

  // ignore: non_constant_identifier_names
  void Save_Data() async {
    var pref = await SharedPreferences.getInstance();
    pref.setStringList('names', mydata);
  }

  // ignore: non_constant_identifier_names
  void Get_Data() async {
    var pref = await SharedPreferences.getInstance();
    olddata = pref.getStringList('names') ?? olddata;
    setState(() {
      mydata = olddata;
    });
  }

  @override
  void initState() {
    super.initState();
    Get_Data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Tile'),
      ),
      body: Column(
        children: [
          TextField(
            controller: text1,
            decoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 350),
              hintText: 'Enter Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const ContinuousRectangleBorder(),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 40)),
              onPressed: () {
                Save_Data();
                setState(() {
                  mydata.add(text1.text);
                });
              },
              child: const Text('Click')),
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: mydata.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Card(
                  //   surfaceTintColor: Colors.yellow,

                  Dismissible(
                    key: Key(mydata[index]),
                    onDismissed: (direction) {
                      final removeItem = mydata[index];
                      Save_Data();
                      setState(() {
                        mydata.removeAt(index);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$removeItem Removed')));
                    },
                    child: ListTile(
                      minTileHeight: 80,
                      leading: CircleAvatar(
                        child:
                            Text(mydata[index].substring(0, 1).toUpperCase()),
                      ),
                      title: Text(
                        mydata[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: (Text('${textdemo.substring(0, 50)}...')),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.cancel)),
                      onTap: () {
                        print('Tap');
                      },
                    ),
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
