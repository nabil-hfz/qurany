// import 'package:flutter/material.dart';
// import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
// import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
//
// class RecitersListScreen extends StatelessWidget {
//   const RecitersListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           translate.reciters,
//           style: TextStyle(color: Colors.green),
//         ),
//         actions: [
//           OutlinedButton(
//             onPressed: () {
//               print('OutlinedButton Jajsdsad');
//               currentlyPlaying.value = audioExamples.first;
//             },
//             child: Text(
//               'Jajsdsad',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           for (AudioObject audioObject in audioExamples)
//             AudioListTile(
//               audioObject: audioObject,
//               onTap: () {
//                 print('audioObject is $audioObject');
//
//                 currentlyPlaying.value = audioObject;
//               },
//             ),
//         ],
//       ),
//     );
//   }
//
//   /// Prevents the game from showing game-services-related menu items
//   /// until we're sure the player is signed in.
//   ///
//   /// This normally happens immediately after game start, so players will not
//   /// see any flash. The exception is folks who decline to use Game Center
//   /// or Google Play Game Services, or who haven't yet set it up.
//   Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
//     return FutureBuilder<bool>(
//       future: ready,
//       builder: (context, snapshot) {
//         // Use Visibility here so that we have the space for the buttons
//         // ready.
//         return Visibility(
//           visible: snapshot.data ?? false,
//           maintainState: true,
//           maintainSize: true,
//           maintainAnimation: true,
//           child: child,
//         );
//       },
//     );
//   }
//
//   static const _gap = SizedBox(height: 10);
// }
//
// const Set<AudioObject> audioExamples = {
//   AudioObject('Salt & Pepper', 'Dope Lemon',
//       'https://m.media-amazon.com/images/I/81UYWMG47EL._SS500_.jpg'),
//   AudioObject('Losing It', 'FISHER',
//       'https://m.media-amazon.com/images/I/9135KRo8Q7L._SS500_.jpg'),
//   AudioObject('American Kids', 'Kenny Chesney',
//       'https://cdn.playbuzz.com/cdn/7ce5041b-f9e8-4058-8886-134d05e33bd7/5c553d94-4aa2-485c-8a3f-9f496e4e4619.jpg'),
//   AudioObject('Wake Me Up', 'Avicii',
//       'https://upload.wikimedia.org/wikipedia/en/d/da/Avicii_Wake_Me_Up_Official_Single_Cover.png'),
//   AudioObject('Missing You', 'Mesto',
//       'https://img.discogs.com/EcqkrmOCbBguE3ns-HrzNmZP4eM=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-12539198-1537229070-5497.jpeg.jpg'),
//   AudioObject('Drop it dirty', 'Tavengo',
//       'https://images.shazam.com/coverart/t416659652-b1392404277_s400.jpg'),
//   AudioObject('Cigarettes', 'Tash Sultana',
//       'https://m.media-amazon.com/images/I/91vBpel766L._SS500_.jpg'),
//   AudioObject('Ego Death', 'Ty Dolla \$ign, Kanye West, FKA Twigs, Skrillex',
//       'https://static.stereogum.com/uploads/2020/06/Ego-Death-1593566496.jpg'),
// };
