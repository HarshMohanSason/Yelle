
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceProviderInformation {

  final String imageUrl;
  final String name;
  final String occupation;
  final int experience;
  final String location;
  final String serviceProviderDocID;

  ServiceProviderInformation(this.imageUrl, this.name, this.occupation, this.experience, this.location, this.serviceProviderDocID);


  static Future<List<ServiceProviderInformation>> getServiceProviderInformation(String occupation) async
  {
    List<ServiceProviderInformation> serviceProviderInformation = [];
    try{

      var snapshot = await FirebaseFirestore.instance
          .collection('serviceProviderInfo')
          .where('Occupation', isEqualTo: occupation)
          .get();

     for(var eachDoc in snapshot.docs)
       {
         ServiceProviderInformation obj = ServiceProviderInformation(eachDoc['imageUrl'], eachDoc['Name'], eachDoc['Occupation'], eachDoc['Experience'], eachDoc['Location'],eachDoc.id);
         serviceProviderInformation.add(obj);
       }
    }
    catch(e)
    {
     // print(e);
    }
    return serviceProviderInformation;
  }

  static Future<bool> uploadServiceProviderInformation(ServiceProviderInformation obj) async{

    try{
     FirebaseFirestore.instance.collection('serviceProviderInfo').doc(FirebaseAuth.instance.currentUser!.uid).update(obj.toMap(obj));
     return true;
    }
    catch(e)
    {
      //
    }
    return false;
  }

  Map<String, dynamic> toMap(ServiceProviderInformation obj)
  {

    return {
      'imageUrl': obj.imageUrl,
      'Name': obj.name,
      'Occupation': obj.occupation,
      'Experience': obj.experience,
      'serviceProviderDocID': obj.serviceProviderDocID,
      'Location': obj.location
    };
  }
}