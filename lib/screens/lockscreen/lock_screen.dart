import 'package:flutter_app_advance/screens/lockscreen/Numpad.dart';
import 'package:flutter/material.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  int lenght = 6;

  // onChange(String number){
  //   if(number.length == lenght){
  //     if(number == '123456'){
  //       Navigator.pushReplacementNamed(context, '/dashboard');
  //     }else{
  //       number=null;
  //       _showDialog('แจ้งเตือน', 'รหัสผ่านไม่ถูกต้อง');
  //     }
  //   }
  // }
  // void _showDialog(title,msg){
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context){
  //       return AlertDialog(
  //         title: Text(title) ,
  //         content: Text(msg),
  //         actions: [
  //           FlatButton(
  //             onPressed: (){Navigator.of(context).pop();},
  //             child: Text('close'))
  //         ],
  //       );
  //     }
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/menu_icon/picture_color.png',
              width: 80,
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'กรุณาใส่รหัสผ่าน',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            // Numpad(length: lenght, onChange: onChange,)
            Numpad(length: lenght)
          ],
        ),
      ),
    );
  }
}
