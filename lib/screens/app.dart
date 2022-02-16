import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  StreamSubscription<bool> keyboardSubscription;
  FocusNode focusNode = FocusNode();
  final TextEditingController _inputKeyInProductCodeController =
      TextEditingController();
  bool isKeyboard = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');

      setState(() {
        isKeyboard = visible;
      });

      if (!visible) {
        FocusScope.of(context).unfocus();
      }

      // updatedText
      if (_inputKeyInProductCodeController.text != "" && !visible) {
        _inputKeyInProductCodeController.value.copyWith(text: "4");
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    _inputKeyInProductCodeController.dispose();
    keyboardSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: buildMenu(),
              ),
              Expanded(
                flex: 1,
                child: buildListItem(),
              ),
            ],
          ),
          isKeyboard
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'ปิด Keyboard',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildMenu() {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width * 0.7,
      // color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: GridView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemCount: 300,
                    itemBuilder: (BuildContext context, int index) {
                      return buildMenuCard();
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuCard() {
    return Container(
      width: double.infinity,
      color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              // height: double.infinity,
              color: Colors.black12,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              // height: double.infinity,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem() {
    final size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: size.height,
        maxHeight: size.height,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("จำนวนสินค้า"),
                      const SizedBox(
                        width: 3,
                      ),
                      Container(
                        // height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2.0,
                            color: const Color.fromRGBO(209, 215, 231, 1),
                          ),
                        ),
                        child: TextField(
                          // obscureText: true,
                          keyboardType: TextInputType.number,
                          // maxLength: 4,
                          // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: 'Enter',
                            isDense: true,
                            // labelText: 'Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("กรอกรหัสสินค้า"),
                        const SizedBox(
                          width: 3,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2.0,
                              color: const Color.fromRGBO(209, 215, 231, 1),
                            ),
                          ),
                          child: TextField(
                            // obscureText: true,
                            focusNode: focusNode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.go,
                            controller: _inputKeyInProductCodeController,
                            onSubmitted: (value) {
                              print("search ---------------------------->");
                              print(value);
                            },
                            onChanged: (value) {
                              print(
                                  "search: onChanged ---------------------------->");
                              print(value);
                            },
                            // onChanged: (value) => doubleVar = double.parse(value),
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: 'Enter',
                              isDense: true,
                              // labelText: 'Password',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: size.height - 210,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(104, 120, 171, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Row(
                                            children: const [
                                              Text(
                                                'สรุปรายการสินค้า',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                '(0 รายการ)',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          textStyle:
                                              const TextStyle(fontSize: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            'พักบิล',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text('ไม่มีรายการสินค้า'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                            left: 8.0,
                            right: 8.0,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "ราคารวม",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "00.00",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "ส่วนลด",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "00.00",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "ภาษีมูลค่าเพิ่ม (10%) ",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "00.00",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "ราคาสุทธิ",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "00.00",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(168, 7, 26, 1),
                          textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: const Text('ยกเลิกการขาย'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(0, 150, 76, 1),
                          textStyle: const TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: const Text('ชำระเงิน'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
