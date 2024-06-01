import 'dart:developer';

import 'package:shreemad_bhagavad_gita_app/headers.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     DataProvider listenable = Provider.of<DataProvider>(context);
//     DataProvider unlistenable =
//         Provider.of<DataProvider>(context, listen: false);
//
//     AppData listener = Provider.of<AppData>(context);
//     AppData unlistener = Provider.of<AppData>(context, listen: false);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         // child: listener.allData.isNotEmpty
//         child: listenable.allData.isNotEmpty
//             // child: listenable.mapData.isNotEmpty
//             ? ListView.builder(
//                 // itemCount: listener.allData.length,
//                 itemCount: listenable.allData.length,
//                 // itemCount: listenable.mapData.length,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(
//                     // listener.allData[index].title,
//                     listenable.allData[index].title,
//                     // listenable.mapData[index]['title'],
//                     style: TextStyle(color: Colors.primaries[index % 18]),
//                   ),
//                 ),
//               )
//             : Center(
//                 child: Column(
//                   children: [
//                     const CircularProgressIndicator(),
//                     GestureDetector(
//                       onTap: () {
//                         // log(
//                         //   listener.allData[0] as String,
//                         // );
//                         log(
//                           listenable.allData[0] as String,
//                         );
//                         // log(
//                         //   listenable.mapData[0]['userId'],
//                         // );
//                       },
//                       child: const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: ColoredBox(
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("श्रीमद् भागवत गीता",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xff4E000E),
        foregroundColor: Colors.white,
        actions: [
          Consumer<slokacontroller>(builder: (context, Provider, child) {
            return IconButton(
                onPressed: () {
                  Provider.listchange();
                },
                icon: Icon(Provider.list ? Icons.list : Icons.grid_view));
          })
        ],
      ),
      body: Consumer<slokacontroller>(builder: (context, Provider, child) {
        return FutureBuilder(
          future: JsonHelper.jsonHelper.getSloka(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Provider.list
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Object data = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("Sloka_Page", arguments: data);
                            },
                            title: Text(
                              "${snapshot.data![index]["name"]}",
                            ),
                            subtitle: Text(
                              "${snapshot.data![index]["name_translation"]}",
                            ),
                            tileColor: const Color(0xff4E000E).withOpacity(0.4),
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xff4E000E),
                              foregroundColor: Colors.white,
                              child: Text("${snapshot.data![index]["id"]}"),
                            ),
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Object data = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("Sloka_Page", arguments: data);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/image/bhagavat.jpg"),
                                fit: BoxFit.cover,
                              )),
                              child: Center(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: const Color(0xff4E000E),
                                      child:
                                          Text("${snapshot.data![index]["id"]}",
                                              style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "${snapshot.data![index]["name"]}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          )),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              )),
                        );
                      },
                    );
            } else if (snapshot.hasError) {
              return Text("${snapshot.hasError}");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }
}
