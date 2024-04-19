import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qur_an/models/ListCity.dart';
import 'package:qur_an/models/city.dart';
import 'package:qur_an/services/city_service.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/scaffold_gradient.dart';
import 'package:qur_an/widgets/search_box.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  City city = City(status: false, data: []);
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('mantap');
    fetchCities();
  }

  fetchCities() async {
    City city = await CityService.fetchCities();

    // if (!city.status) {
    //   print('mantap');
    // }
    setState(() {
      this.city = city;
      isLoading = false;
    });
  }

  changeHandler(String value) async {
    City city = await CityService.fetchCities(search: value);

    setState(() {
      this.city = city;
    });
  }

  Widget build(BuildContext context) {
    return ScaffoldGradient(
      title: SearchBox(
          changeHandler: changeHandler, hintText: "Cari kota atau kabupaten"),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xFF65D6FC), size: 40),
            )
          : ListView.builder(
              itemCount: city.data.length,
              itemBuilder: (context, index) {
                final ListCity item = city.data[index];
                return ItemCity(item: item);
              },
            ),
    );
  }
}

class ItemCity extends StatelessWidget {
  const ItemCity({
    super.key,
    required this.item,
  });

  final ListCity item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.secondaryColor)),
          ),
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 5, left: 5, top: 5),
          margin: EdgeInsets.only(bottom: 10),
          child: Text(item.lokasi),
        )
      ],
    );
  }
}
