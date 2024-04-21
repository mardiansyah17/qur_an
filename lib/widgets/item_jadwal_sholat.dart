import 'package:flutter/material.dart';
import 'package:qur_an/utils/app_colors.dart';

class ItemJadwalSholat extends StatefulWidget {
  const ItemJadwalSholat({
    super.key,
    this.isActivated = false,
    required this.title,
    this.time = "1:00",
  });

  final bool isActivated;
  final String title;
  final String time;

  @override
  State<ItemJadwalSholat> createState() => _ItemJadwalSholatState();
}

class _ItemJadwalSholatState extends State<ItemJadwalSholat> {
  @override
  Widget build(BuildContext context) {
    final color = widget.isActivated
        ? Color.fromARGB(255, 0, 108, 167)
        : AppColors.primaryColor;
    return Container(
      decoration: BoxDecoration(
        color: widget.isActivated ? AppColors.primaryColor : null,
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.notifications_active,
                  color: color,
                  size: 17,
                ),
              ),
              Text(widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                  )),
            ],
          ),
          Text(widget.time,
              style: TextStyle(
                fontSize: 16,
                color: color,
              )),
        ],
      ),
    );
  }
}
