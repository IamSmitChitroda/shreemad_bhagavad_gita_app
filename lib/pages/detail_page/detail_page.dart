import 'package:shreemad_bhagavad_gita_app/headers.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4E000E),
        foregroundColor: Colors.white,
        title: Text(
          "श्लोक:${data["verse_number"]}",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<slokacontroller>(context, listen: false)
                    .languageChange();
              },
              icon: Icon(Icons.translate))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<slokacontroller>(builder: (context, Provider, child) {
          return Container(
            padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/page.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText("श्लोक:${data["verse_number"]}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                    "${Provider.translate ? data["text"] : data["transliteration"]}",
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
