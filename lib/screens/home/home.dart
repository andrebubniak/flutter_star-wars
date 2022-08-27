import 'package:flutter/material.dart';
import '/commom/main_app_bar.dart';

class Home extends StatefulWidget 
{
  const Home({Key? key}) : super(key: key);
  

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
{

  Widget tabContainer(Tab tab)
  {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4)
      ),
      child: tab
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [ 
              TabBar(
                indicatorWeight: .1,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  tabContainer(const Tab(text: "Filmes", height: 30)),
                  tabContainer(const Tab(text: "Personagens", height: 30)),
                  tabContainer(const Tab(text: "Favoritos", height: 30)),
                ],
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height/1.5,
                child: TabBarView(
                  children: [
                    Center(child: Text("Filmes"),),
                    Center(child: Text("Personagens"),),
                    Center(child: Text("Favoritos"),)
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
    
  }
}