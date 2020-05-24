import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantshop/models/plant_model.dart';
import 'package:plantshop/screens/plant_screen.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _plantSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.35)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PlantScreen(plants[index])),
          )
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF32A060),
                  borderRadius: BorderRadius.circular(20.0)),
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Hero(
                        tag: plants[index].imageUrl,
                        child: Image(
                          height: 200.0,
                          width: 200.0,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/plant$index.png'),
                        )),
                  ),
                  Positioned(
                    top: 30.0,
                    right: 30.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "FROM",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        Text(
                          "\$ ${plants[index].price}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    bottom: 40.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: plants[index].category,
                          transitionOnUserGestures: true,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              child: Text(
                                plants[index].category.toUpperCase(),
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          plants[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 4.0,
              left: 0.0,
              right: 0.0,
              child: RawMaterialButton(
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(
                    side: BorderSide(width: 5.0, color: Colors.white)),
                elevation: 0.0,
                fillColor: Colors.black,
                child: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () => print("Add to cart"),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.menu,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Top Pics",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.6),
              labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Top",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "OutDoor",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "InDoor",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "New Arrivals",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Limited Edition",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 380.0,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: plants.length,
                itemBuilder: (BuildContext context, int index) {
                  return _plantSelector(index);
                },
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    plants[_selectedPage].description,
                    style: TextStyle(color: Colors.black87, fontSize: 16.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
