import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yelle/Messaging/message_screen_ui.dart';
import 'package:yelle/Services/service_provider_information.dart';
import 'package:yelle/Services/service_type_display.dart';
import '../ReusableWidgets/search_bar.dart';
import '../main.dart';

class ServiceType extends StatefulWidget {

  final String serviceType;

  const ServiceType({super.key, required this.serviceType});

  @override
  State<ServiceType> createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {

  late Future<List<ServiceProviderInformation>> serviceProvider;

  @override
  void initState() {
    super.initState();
    getServiceData();
  }

  void getServiceData() async {
    serviceProvider = ServiceProviderInformation.getServiceProviderInformation(
        widget.serviceType);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Platform.isAndroid ? true : false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight / 15),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFE9900), // Start color
                    Color(0xFFFFBE00),
                    // End color
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back), // Use arrow_back icon
                onPressed: () {
                  Navigator.pop(context); // Handles back navigation
                },
              ),
              backgroundColor: Colors.transparent,
              title: Text(
                "SERVICES",
                style: TextStyle(
                    fontFamily: 'Plus_Jakarta_Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth / 18),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: FutureBuilder(

            future: serviceProvider,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                Fluttertoast.showToast(
                  msg: snapshot.error.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  textColor: Colors.white,
                  backgroundColor: Colors.red,
                  fontSize: 14.0,
                );
                return Center(child: Text(snapshot.error.toString(), style: TextStyle(
                    fontFamily: 'Plus_Jakarta_Sans',
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth / 18),));
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                    color: Colors.black,
                  ),
                );
              }
              else if(snapshot.data.length == 0)
                {
                  return Center(child: Text("No one available for this occupation", style: TextStyle(
                      fontFamily: 'Plus_Jakarta_Sans',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth / 25),));
                }
              else {

                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SearchBarApp(
                            searchHintText: widget.serviceType)),
                    const SizedBox(height: 30,),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,
                          int index) {
                        return InkWell(
                            onTap: ()
                            {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreenUi(messageReceiverName: snapshot.data[index].name, messageReceiverImage:snapshot.data[index].imageUrl, receiverID: snapshot.data[index].uid)));
                            },
                            child: ServiceTypeDisplay(serviceProviderInformation: snapshot.data[index]));
                      },

                    ),
                  ],
                );
              }
            },

          ),
        ),

      ),
    );
  }
}