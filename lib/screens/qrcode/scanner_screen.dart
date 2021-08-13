import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:flutter/services.dart' show rootBundle;

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  // สร้าง object ส่วนสำหรับเรียกตัวแสกน QR
  QRViewController _controller;
  GlobalKey _qrKey = GlobalKey();
  bool _flashOn = false;
  bool _frontCam = false;

  File _image;
  String _data = '';
  String _qrcodeFile = '';

  // สร้าง method สำหรับการเลือกรูปจาก Gallery
  Future getImage() async {
    var image = await ImagePickerSaver.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('image = '+_image.toString());
      Fluttertoast.showToast(
          msg: 'image = '+_image.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String filename = 'qrcode_no_image.png';
    Observable.fromFuture(getTemporaryDirectory())
        .flatMap((tempDir) {
          File qrCodeFile = File('${tempDir.path}/$filename');
          bool exists = qrCodeFile.existsSync();
          if (exists) {
            return Observable.just(qrCodeFile);
          } else {
            return Observable.fromFuture(rootBundle.load("images/$filename"))
                .flatMap((bytes) => Observable.fromFuture(
                    qrCodeFile.writeAsBytes(bytes.buffer.asUint8List(
                        bytes.offsetInBytes, bytes.lengthInBytes))));
          }
        })
        .flatMap(
            (file) => Observable.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path)))
        .listen((data) {
          setState(() {
            _data = data;
          });

        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container( color: Colors.blue,), // ใส่พื้นสี
        QRView(
          key: _qrKey, 
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderLength: 15.0,
            borderWidth: 5.0,
            borderRadius: 2.0
          ),
          onQRViewCreated: (QRViewController controller){
            this._controller = controller;
            // รับค่ามาใช้งาน
            controller.scannedDataStream.listen((val) {
              print('QR Code = '+val);
              if(mounted){
                Fluttertoast.showToast(
                    msg: 'QR Code = '+val,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
              _controller.dispose();
              //ปิดหน้า Scan
              Navigator.pop(context);
            });
          }
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 60.0),
            child: Text(
              'วางคิวอาร์โค้ดให้อยู่ในกรอบเพื่อแสกน',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 80.0),
            child: OutlineButton(
              onPressed: _getPhotoByGallery,
              child: Text(
                'นำเข้าจากแกลอรี่',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              borderSide: BorderSide(color: Colors.white),
              shape: StadiumBorder(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                  onPressed: (){
                    setState(() {
                      _flashOn = !_flashOn;
                      _controller.toggleFlash();
                    });
                  }
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(_frontCam ? Icons.camera_front : Icons.camera_rear),
                  onPressed: (){
                    setState(() {
                      _frontCam = !_frontCam;
                      _controller.flipCamera();
                    });
                  }
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: (){
                    Navigator.pop(context);
                  }
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _getPhotoByGallery(){
    Observable.fromFuture(ImagePickerSaver.pickImage(source: ImageSource.gallery))
    .flatMap((file){
      setState(() {
        _qrcodeFile = file.path;
      });
      return Observable.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path));
    }).listen((data){
      setState(() {
        _data = data;
        // _showSnackbar(context, _data.toString());
        print('QR code = '+_data.toString());
        Fluttertoast.showToast(
            msg: 'QR code = '+_data.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        _controller.dispose();
        //ปิดหน้า Scan
        Navigator.pop(context);
      });
    }).onError((error, stackTrace){
      setState(() {
        _data = '';
      });
      print('error import QR Code : ${error.toString()}');
      Fluttertoast.showToast(
          msg: 'ไม่สามารถอ่าน QR Code ได้',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _controller.dispose();
      //ปิดหน้า Scan
      Navigator.pop(context);
    });

  }

}