import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantshop/models/plant_model.dart';

class PlantScreen extends StatefulWidget {
  final Plant plant;

  PlantScreen(this.plant);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 480.0,
                    color: Color(0xFF32A060),
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              child: Icon(
                                Icons.arrow_back,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Icon(
                              Icons.shopping_cart,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Hero(
                          tag: widget.plant.category,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              child: Text(
                                widget.plant.category.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.plant.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          "FROM",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "\$ ${widget.plant.price}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          "SIZE",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.plant.size,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RawMaterialButton(
                          padding: EdgeInsets.all(20.0),
                          shape: CircleBorder(
                              side:
                                  BorderSide(width: 3.0, color: Colors.white)),
                          elevation: 4.0,
                          fillColor: Colors.black,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () => print("Add to cart"),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 30.0,
                    child: Hero(
                      tag: widget.plant.imageUrl,
                      child: Image(
                        height: 250.0,
                        width: 250.0,
                        fit: BoxFit.cover,
                        image: AssetImage(widget.plant.imageUrl),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 400.0,
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "All to know...",
                            style: TextStyle(
                                fontSize: 26.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.plant.description,
                            style: TextStyle(
                                color: Colors.black87, fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Details",
                            style: TextStyle(
                                fontSize: 26.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            "Plant Height : 35-45 cm",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black87),
                          ),
                          Text(
                            "Nursery pot width : 12 cm",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black87),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
