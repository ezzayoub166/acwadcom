// import 'dart:async';
// import 'dart:developer';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// import 'dart:async';
// import 'dart:developer';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// enum InternetState { initial, gained, lost }

// class InternetCubit extends Cubit<InternetState> {
//   final Connectivity _connectivity = Connectivity();
//   StreamSubscription? _connectivitySubscription;

//   InternetCubit() : super(InternetState.initial) {
//     _checkConnectivity();

//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen((result) async {
//       if (result == ConnectivityResult.mobile ||
//           result == ConnectivityResult.wifi) {
//         bool isConnected = await _checkInternetConnection();
//         if (isConnected) {
//           emit(InternetState.gained);
//           log("Internet connected");
//         } else {
//           emit(InternetState.lost);
//           log("No internet access despite being connected to a network");
//         }
//       } else {
//         emit(InternetState.lost);
//         log("No network connection");
//       }
//     });
//   }

//   Future<void> _checkConnectivity() async {
//     try {
//       var connectivityResult = await _connectivity.checkConnectivity();
//       if (connectivityResult == ConnectivityResult.mobile ||
//           connectivityResult == ConnectivityResult.wifi) {
//         bool isConnected = await _checkInternetConnection();
//         if (isConnected) {
//           emit(InternetState.gained);
//           log("Initial connectivity check: Internet connected");
//         } else {
//           emit(InternetState.lost);
//           log("Initial connectivity check: No internet access");
//         }
//       } else {
//         emit(InternetState.lost);
//         log("Initial connectivity check: No network connection");
//       }
//     } catch (e) {
//       print("Error checking connectivity: $e");
//       emit(InternetState.lost);
//     }
//   }

//   Future<bool> _checkInternetConnection() async {
//     try {
//       final result = await http.get(Uri.parse('https://www.google.com'))
//           .timeout(Duration(seconds:30));
//       return result.statusCode == 200;
//     } catch (_) {
//       return false;
//     }
//   }

//   @override
//   Future<void> close() {
//     _connectivitySubscription?.cancel();
//     return super.close();
//   }
// }




// class NetworkObserverCubit extends StatefulWidget {
//   final Widget child;

//   const NetworkObserverCubit({super.key, required this.child});

//   @override
//   _NetworkObserverCubitState createState() => _NetworkObserverCubitState();
// }

// class _NetworkObserverCubitState extends State<NetworkObserverCubit> {
//   void showSnackBar(String text, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(text),
//         backgroundColor: color,
//       ),
//     );
//   }


//   Future<void> _sendVoiceDialog(String message) async {
//     await _flutterTts.speak(message);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<InternetCubit, InternetState>(
//         listener: (context, state) {
//       if (state == InternetState.gained) {
//         showSnackBar("Internet Connected Successfully..", Colors.green);
//         _sendVoiceDialog("Internet Connected Successfully ..");
//       }
//       if (state == InternetState.lost) {
//         showSnackBar("Internet Disconnected..", Colors.red);
//         // _sendVoiceDialog("Internet Disconnected..");
//       }
//     }, builder: (context, state) {
//       if (state == InternetState.gained) {
//         return widget.child;
//       }
//       if (state == InternetState.lost) {
//         return const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.wifi_off_outlined,
//                 size: 40,
//                 color: Colors.red,
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 "Internet Disconnected...",
//                 style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         );
//       }
//       return const Center(child: Text("Loading..."));
//     });
//   }
// }