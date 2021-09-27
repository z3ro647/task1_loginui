import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_loginui/models/order.dart';

final colorGreen = HexColor("#09b976");

class ListData extends StatefulWidget {
  const ListData({ Key? key }) : super(key: key);

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Order> orders = [
    Order(orderno: 'TR0714806', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0721114', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0721789', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0721872', origin: 'PRIMELINE', destination: 'S031'),
    //Order(orderno: 'TR0724508', origin: 'S025', destination: 'S031'),
    Order(orderno: 'TR0725268', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0725397', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0725398', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0725631', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0726451', origin: 'PRIMELINE', destination: 'S031'),
    Order(orderno: 'TR0726574', origin: 'PRIMELINE', destination: 'S031'),
  ];

  Widget orderDetailCard(Order) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(elevation: 0,
      color: Colors.transparent,
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              Order.orderno,
              textAlign: TextAlign.center,
            ),
            Text(
              Order.origin,
              textAlign: TextAlign.center,
            ),
            Text(
              Order.destination,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transfer Recipt',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        backgroundColor: colorGreen,
        actions: [
          IconButton(
              onPressed: () {
                print('Search Call');
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              color: HexColor('#f5f5f5'),
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Order No.',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'From Location',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'To Location',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Column(
              children: orders.map((o) {
                return Column(
                  children: [
                    orderDetailCard(o),
                    Divider()
                  ]
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}