import 'package:flutter/material.dart';

import 'model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVisibility = false;
  bool addResultIsVisibility = false;
  TextEditingController inputTex = TextEditingController();
  List<ModelById> searchResults = [
    ModelById(id: "1", name: "Bangladesh"),
    ModelById(id: "2", name: "india"),
    ModelById(id: "3", name: "china"),
    ModelById(id: "4", name: "brazil"),
    ModelById(id: "5", name: "usa"),
    ModelById(id: "6", name: "uk"),
  ];
  List<ModelById> addResult = [];
  showMyResult() {
    List<ModelById> suggestions = searchResults.where((searchResult) {
      final result = searchResult;
      final input = inputTex.text.toLowerCase();

      return result.name.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion.name),
          onTap: () {
            if (!addResult.contains(suggestion)) {
              addResult.add(suggestion);
            }

            if (addResult.isNotEmpty && addResultIsVisibility == false) {
              addResultIsVisibility = true;
            }
            setState(() {});
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Wrap(children: [
                  TextFormField(
                    controller: inputTex,
                    onTap: () {
                      isVisibility = true;
                      setState(() {});
                    },
                    onFieldSubmitted: (value) {
                      isVisibility = false;
                      setState(() {});
                    },
                    onChanged: (value) {
                      if (inputTex.text != "") {
                        isVisibility = true;
                        setState(() {});
                      } else {
                        isVisibility = false;
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Search Service Category"),
                  ),
                  Visibility(
                    visible: addResultIsVisibility,
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: addResult.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 2, color: Colors.grey)),
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      border:
                                          Border(right: BorderSide(color: Colors.grey, width: 2))),
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      addResult.remove(addResult[index]);
                                      if (addResult.isEmpty) {
                                        if (addResultIsVisibility == true) {
                                          addResultIsVisibility = false;
                                        }
                                      }
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(addResult[index].name),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isVisibility,
                      child: SizedBox(
                        height: 70 * searchResults.length.toDouble(),
                        child: showMyResult(),
                      ))
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
