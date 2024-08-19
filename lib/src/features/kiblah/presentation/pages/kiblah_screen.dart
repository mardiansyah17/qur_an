import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';
import 'package:qur_an/src/core/widgets/app_button.dart';
import 'package:qur_an/src/core/widgets/app_loading.dart';
import 'package:location/location.dart';

class KiblahScreen extends StatefulWidget {
  const KiblahScreen({super.key});

  @override
  State<KiblahScreen> createState() => _KiblahScreenState();
}

class _KiblahScreenState extends State<KiblahScreen> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();
  Location location = Location();
  Stream<LocationStatus> get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          }
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return Text('error');
              case LocationPermission.deniedForever:
                return Text('error');

              // case GeolocationStatus.unknown:
              //   return LocationErrorWidget(
              //     error: "Unknown Location service error",
              //     callback: _checkLocationStatus,
              //   );
              default:
                return const SizedBox();
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/animations/location.gif',
                  width: 200,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Aktifkan lokasi untuk melihat arah kiblat',
                ),
                const SizedBox(height: 16),
                AppButton(
                    text: "Aktifkan Lokasi",
                    onPressed: () async {
                      await location.requestService();
                      _checkLocationStatus();
                    }),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final _compassSvg = SvgPicture.asset('assets/svg/compass-qiblah.svg');
  final _needleSvg = SvgPicture.asset(
    'assets/svg/needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  QiblahCompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppLoading();
        }

        final qiblahDirection = snapshot.data!;

        return Container(
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 100,
                child: Text(
                  '${qiblahDirection.direction.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppPallete.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Transform.rotate(
                angle: (qiblahDirection.direction * (pi / 180) * -1),
                child: _compassSvg,
              ),
            ],
          ),
        );
      },
    );
  }
}
