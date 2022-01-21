import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Page1());
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Feed',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Pet Feed'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //增加的自定義部分-----------------
  //int _counter = 0;
  bool secondPage = true;
  String deviceConnect = 'O';
  String wifiConnect = 'O';
  String wifiName = '';
  String password = '';
  int timeRecord = 0;
  var selectedQuality = [1.0,1.0,1.0];
  var selectedWeekdays = [
    [false,false,false,false,false,false,false],
    [false,false,false,false,false,false,false],
    [false,false,false,false,false,false,false]
  ];
  var selectedTime = [TimeOfDay.now(),TimeOfDay.now(),TimeOfDay.now()];
  var selectedSets = [false, false, false];
  var tmpQuality = 1.0;
  var tmpWeekday = [false,false,false,false,false,false,false];
  var tmpTime = TimeOfDay.now();


  void _incrementCounter() {
    setState(() {
      _counter++;
      secondPage = !secondPage;
    });
  }

  // 按鈕函式集中處------------------------------------
  void Connect_onpress() {
    setState(() {
      secondPage = true;
    });
  }

  void TimeSet_onpress() {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));  //原本用來換頁的寫法
    setState(() {
      if(deviceConnect == 'O' && wifiConnect=='O') secondPage = false;
    });
  }

  void Check_onpress() {}

  void Device_onpress() {
    setState(() {
      if (deviceConnect == 'O') deviceConnect = 'X';
      else deviceConnect = 'O';
    });
  }

  void Wifi_onpress() {
    setState(() {
      if (wifiConnect == 'O') wifiConnect = 'X';
      else wifiConnect = 'O';
    });
  }

  void Quality_select(double val){
    setState(() {
      tmpQuality = val;
    });
  }

  void Weekday_select(int idx){
    setState(() {
      tmpWeekday[idx] ^= true;
    });
  }

  void Record_select(int idx){
    setState(() {
      timeRecord = idx;
      tmpQuality = selectedQuality[idx];
      tmpWeekday = List.from(selectedWeekdays[idx]);
      tmpTime = selectedTime[idx];
    });
  }

  void Set_onpress(){
    setState(() {
      selectedQuality[timeRecord] = tmpQuality;
      selectedWeekdays[timeRecord] = List.from(tmpWeekday);
      selectedTime[timeRecord] = tmpTime;
      selectedSets[timeRecord] = true;
    });
  }

  void Del_onpress(){
    setState(() {
      selectedSets[timeRecord] = false;
      selectedQuality[timeRecord] = 1.0;
      selectedWeekdays[timeRecord] = [false,false,false,false,false,false,false];
      tmpWeekday = [false,false,false,false,false,false,false];
      selectedTime[timeRecord] = TimeOfDay.now();
    });
  }

  //--------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 224, 1),
      body: Container(
        //padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),  //最上方的元件和頂層的隔開空間 (美觀用)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              //上層 connect 和 Time set 按鈕
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: Connect_onpress,
                  child: const Text('Connect',),
                ),
                ElevatedButton(
                  onPressed: TimeSet_onpress,
                  child: const Text('Time Set',),
                ),
              ],
            ), //上層 connect 和 Time set 按鈕
            Container(
              height: 3,
              color: Colors.black,
            ), // 分割線
            //----------------------------------------------------------------------------------
            Offstage( //第一頁
              offstage: !secondPage,
              child: Column(children: [
                const Text(
                  'Connect to wifi and get time',
                  style: TextStyle(color: Colors.red),
                ),
                Row(// 顯示字和輸入框區域
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      //直向對齊顯示文字
                      children: const [
                        Text(
                          'Wifi name       ',
                        ),
                        Text(''),
                        Text('Wifi password'),
                      ],
                    ), // 直向對齊顯示文字
                    Container(width: 30,), // 隔開顯示字跟輸入框 (排版用，本身沒用途)
                    Column(// 兩個輸入框 (直向排列)
                      children: [
                        Container(
                          // wifi name 輸入框
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black)),
                          child: TextField(
                            onChanged: (text) => wifiName = text,
                            decoration: const InputDecoration(
                              hintText: 'Wifi name',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ), // wifi name 輸入框
                        Container(
                          // password 輸入框
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black)),
                          child: TextField(
                            onChanged: (text) => password = text,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ) // password 輸入框
                      ],
                    )// 兩個輸入框 (直向排列)
                  ],
                ), //顯示字跟輸入框區域
                ElevatedButton(
                  // check 按鈕
                  onPressed: Check_onpress,
                  child: const Text(
                    'Check',
                  ),
                ), // check 按鈕
                Container(
                  height: 3,
                  color: Colors.black,
                ), // 分割線
                //-----------------------------------------------------------------------------
                Row(
                  // 下層 Device 和 wifi 按鈕
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      //左側 Device 上面的圓圈及按鈕
                      children: [
                        Text(
                          deviceConnect,
                          style: const TextStyle(fontSize: 30),
                        ),
                        ElevatedButton(
                            onPressed: Device_onpress,
                            child: const Text(
                              'Device',
                            ),
                        )
                      ],
                    ), // 左側 Device 上面的圓圈及按鈕
                    Column(
                      // 右側 wifi 上面的圓圈及按鈕
                      children: [
                        Text(
                          wifiConnect,
                          style: const TextStyle(fontSize: 30),
                        ),
                        ElevatedButton(
                            onPressed: Wifi_onpress,
                            child: const Text(
                              'Wifi',
                            ),
                        )
                      ],
                    ), // 右側 wifi 上面的圓圈及按鈕
                  ],
                ),// 下層 Device 和 wifi 按鈕
                const Text('1. Set Wifi and restart power.\n2. Wait 10 seconds and restart app\n3. Check Device and Wifi are "O"'),
              ],),
            ), //第一頁
            Offstage( //第二頁
              offstage: secondPage,
              child: Column(
                children: [
                  Row(  //三組提示字
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('TimeSet 1', style: TextStyle(fontSize: 20),),
                      Text('TimeSet 2', style: TextStyle(fontSize: 20),),
                      Text('TimeSet 3', style: TextStyle(fontSize: 20),),
                    ],
                  ),//三組提示字
                  Row(  //三個選擇按鈕
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Radio(value: 0, groupValue: timeRecord,
                          onChanged: (newValue){Record_select(newValue as int);} ),
                      Radio(value: 1, groupValue: timeRecord,
                          onChanged: (newValue){Record_select(newValue as int);} ),
                      Radio(value: 2, groupValue: timeRecord,
                          onChanged: (newValue){Record_select(newValue as int);} ),
                    ],
                  ),//三個紀錄組按鈕
                  Container(
                    height: 3,
                    color: Colors.black,
                  ), // 分割線
                  //---------------------------------------------------------------
                  Text('Quality: ${tmpQuality.round()}', style: const TextStyle(fontSize: 30),),
                  Slider(value: tmpQuality, //分量拉條
                      max: 3,
                      min: 1,
                      divisions: 2,
                      onChanged: (value){Quality_select(value);}
                      ), //分量拉條
                  Row(  //第一排選星期
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            //Radio(value: 'Mon', groupValue: tmpWeekday, onChanged: (wd){Weekday_select(wd as String);}),
                            Checkbox(
                                value: tmpWeekday[0],
                                onChanged: (value){Weekday_select(0);}),
                            const Expanded(child: Text('Mon')),
                          ],
                        ),
                        flex: 1,
                      ), //星期一
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                value: tmpWeekday[1],
                                onChanged: (value){Weekday_select(1);}),
                            const Expanded(child: Text('Tue'))
                          ],
                        ),
                        flex: 1,
                      ), //星期二
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                value: tmpWeekday[2],
                                onChanged: (value){Weekday_select(2);}),
                            const Expanded(child: Text('Wed'))
                          ],
                        ),
                        flex: 1,
                      ), //星期三
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                value: tmpWeekday[3],
                                onChanged: (value){Weekday_select(3);}),
                            const Expanded(child: Text('Thu'))
                          ],
                        ),
                        flex: 1,
                      ), //星期四
                    ],
                  ),//第一排選星期
                  Row(  //第二排選星期
                    children: [
                      Expanded(child: Container(),flex: 1,),  //美觀用的空格
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                value: tmpWeekday[4],
                                onChanged: (value){Weekday_select(4);}),
                            Expanded(child: const Text('Fri'))
                          ],
                        ),
                        flex: 1,
                      ), //星期五
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                value: tmpWeekday[5],
                                onChanged: (value){Weekday_select(5);}),
                            const Expanded(child: Text('Sat'))
                          ],
                        ),
                        flex: 1,
                      ), //星期六
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                value: tmpWeekday[6],
                                onChanged: (value){Weekday_select(6);}),
                            const Expanded(child: Text('Sun'))
                          ],
                        ),
                        flex: 1,
                      ), //星期日
                      Expanded(child: Container(),flex: 1,), //美觀用的空格
                    ],
                  ),//第二排選星期
                  IconButton( // 時鐘按鈕
                      icon: const Icon(Icons.access_time),
                      onPressed: ()async{
                        var result = await showTimePicker(
                            context: context,
                            initialTime: tmpTime,
                            initialEntryMode: TimePickerEntryMode.input,
                        );
                        if(result != null){
                          setState(() {
                            tmpTime = result;
                          });
                        }
                      },
                  ),// 時鐘按鈕
                  Text(tmpTime.format(context)),
                  Container(
                    height: 3,
                    color: Colors.black,
                  ), // 分割線
                  //--------------------------------------------------------------------------------
                  Row(//Set 跟 Del 按鈕
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: Set_onpress, child: const Text('Set')),
                      ElevatedButton(onPressed: Del_onpress, child: const Text('Del')),
                    ],
                  ),//Set 跟 Del 按鈕
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: const [
                            Text('Time1:\n'),
                            Text('Time2:\n'),
                            Text('Time3:\n'),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 100,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                                visible: selectedSets[0],
                                replacement: const Text('_ _:_ _  _ _'),
                                child: Text('${selectedTime[0].format(context)},  ${selectedQuality[0].floor()}',style: TextStyle(fontWeight: FontWeight.bold),)
                            ), //時間及份量
                            Row(
                              children: [
                                Text('Mon ',style: TextStyle(color: selectedWeekdays[0][0]?Colors.red:Colors.black26),),
                                Text('Tue ',style: TextStyle(color: selectedWeekdays[0][1]?Colors.red:Colors.black26),),
                                Text('Wed ',style: TextStyle(color: selectedWeekdays[0][2]?Colors.red:Colors.black26),),
                                Text('Thu ',style: TextStyle(color: selectedWeekdays[0][3]?Colors.red:Colors.black26),),
                                Text('Fri ',style: TextStyle(color: selectedWeekdays[0][4]?Colors.red:Colors.black26),),
                                Text('Sat ',style: TextStyle(color: selectedWeekdays[0][5]?Colors.red:Colors.black26),),
                                Text('Sun ',style: TextStyle(color: selectedWeekdays[0][6]?Colors.red:Colors.black26),),
                              ],
                            ),//顯示星期
                            Visibility(
                                visible: selectedSets[1],
                                replacement: const Text('_ _:_ _  _ _'),
                                child: Text('${selectedTime[1].format(context)},  ${selectedQuality[1].floor()}',style: TextStyle(fontWeight: FontWeight.bold),)
                            ), //時間及份量
                            Row(
                              children: [
                                Text('Mon ',style: TextStyle(color: selectedWeekdays[1][0]?Colors.red:Colors.black),),
                                Text('Tue ',style: TextStyle(color: selectedWeekdays[1][1]?Colors.red:Colors.black),),
                                Text('Wed ',style: TextStyle(color: selectedWeekdays[1][2]?Colors.red:Colors.black),),
                                Text('Thu ',style: TextStyle(color: selectedWeekdays[1][3]?Colors.red:Colors.black),),
                                Text('Fri ',style: TextStyle(color: selectedWeekdays[1][4]?Colors.red:Colors.black),),
                                Text('Sat ',style: TextStyle(color: selectedWeekdays[1][5]?Colors.red:Colors.black),),
                                Text('Sun ',style: TextStyle(color: selectedWeekdays[1][6]?Colors.red:Colors.black),),
                              ],
                            ),//顯示星期
                            Visibility(
                                visible: selectedSets[2],
                                replacement: const Text('_ _:_ _  _ _'),
                                child: Text('${selectedTime[2].format(context)},  ${selectedQuality[2].floor()}',style: TextStyle(fontWeight: FontWeight.bold),)
                            ), //時間及份量
                            Row(
                              children: [
                                Text('Mon ',style: TextStyle(color: selectedWeekdays[2][0]?Colors.red:Colors.black),),
                                Text('Tue ',style: TextStyle(color: selectedWeekdays[2][1]?Colors.red:Colors.black),),
                                Text('Wed ',style: TextStyle(color: selectedWeekdays[2][2]?Colors.red:Colors.black),),
                                Text('Thu ',style: TextStyle(color: selectedWeekdays[2][3]?Colors.red:Colors.black),),
                                Text('Fri ',style: TextStyle(color: selectedWeekdays[2][4]?Colors.red:Colors.black),),
                                Text('Sat ',style: TextStyle(color: selectedWeekdays[2][5]?Colors.red:Colors.black),),
                                Text('Sun ',style: TextStyle(color: selectedWeekdays[2][6]?Colors.red:Colors.black),),
                              ],
                            ),//顯示星期
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ), //第二頁
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '+++',
        child: const Icon(Icons.add),
      ),
    );
  }
}