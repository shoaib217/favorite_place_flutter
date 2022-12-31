import 'package:flutter/material.dart';
import 'package:place_app/main.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(MyApp.addPlace),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context,listen: false).fetchAndSetPlaces(),
        builder: (ctx,snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) : Consumer<PlaceProvider>(
          builder: ((ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
              ? ch!
              : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(greatPlaces.items[i].image),
                    ),
                    title: Text(greatPlaces.items[i].title),
                    onTap: () {},
                  ),
                )),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(MyApp.addPlace),
                  icon: const Icon(
                    Icons.add,
                  ),
                  iconSize: 45,
                ),
                const SizedBox(height: 10,),
                const Text('Got no places yet, start adding some!',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
