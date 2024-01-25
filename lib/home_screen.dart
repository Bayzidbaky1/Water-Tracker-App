import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/water_consume.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WatherConsume> waterConsumeList = [];
  final TextEditingController _noOfGlassesController =
      TextEditingController(text: "1");
  final TextEditingController _noteController =
      TextEditingController(text: "Morning");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 3,
        title: const Text(
          "Water Tracker",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      if (_noOfGlassesController.text.trim().isEmpty) {
                        _noOfGlassesController.text = '1';
                      }
                      if (_noteController.text.isEmpty) {
                        _noteController.text = 'Morning';
                        
                      }
                      final noOfGLassess = _noOfGlassesController.text.trim();
                      int value = int.tryParse(noOfGLassess) ?? 1;
                      waterConsumeList.add(WatherConsume(
                          value, DateTime.now(), _noteController.text));

                      setState(() {});
                      _noOfGlassesController.clear();
                      _noteController.clear();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: const Text(
                        "Tap to Add",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 80,
                          child: TextFormField(
                            controller: _noOfGlassesController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _noteController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: waterConsumeList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                              waterConsumeList[index].noOfGLass.toString()),
                        ),
                        title: Text(waterConsumeList[index].title),
                        subtitle: Text(
                            DateFormat.yMEd().add_jms().format(waterConsumeList[index].time)),
                        trailing: IconButton(
                            onPressed: () {
                              waterConsumeList.removeAt(index);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            )),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
