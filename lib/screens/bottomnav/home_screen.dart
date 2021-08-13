import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // สร้างตัวแปลเก็บชื่อแมนู
  var SerVices = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
  ];
  var Images = [
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
    "assets/images/menu_icon/picture_color.png",
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: SerVices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.4)
      ),
      itemBuilder:  (BuildContext context, int index){
        return Card(
          child: InkWell(
              onTap: () {},
              child: Column(
              children: [
                SizedBox(height: 20,),
                Image.asset(Images[index], height: 50, width: 50,),
                Padding(
                  padding: EdgeInsets.all(20),
                  child:  Text(SerVices[index], style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}