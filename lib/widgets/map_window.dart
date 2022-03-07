import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/widgets/app_loading_spinner.dart';
import 'package:provider/provider.dart';

class MapWindow extends StatelessWidget {
  late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
  profileProvider = Provider.of<ProfileProvider>(context);
  LatLng? userPosition = profileProvider.userLocation;
    return Container(
       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
       height: context.screenHeight/4, 
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
       color: Colors.blueGrey),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(15),
         child: userPosition == null ? AppLoadingSpinner() : GoogleMap(
           markers: _getMarker(userPosition),
           initialCameraPosition: 
          CameraPosition(target: profileProvider.userLocation!, zoom: 16.5),
          zoomControlsEnabled: false,
          onTap: (value){
            profileProvider.setNewLocation(value);
          },
         ),
       ),
    );
  }
  Set<Marker> _getMarker(LatLng position){
    Set<Marker> userLocationMarker = [Marker(draggable: true, onDragEnd: (value) => profileProvider.setNewLocation(value), markerId: MarkerId(""), position: position, )].toSet();
    return userLocationMarker;
  }
}