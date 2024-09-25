
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceProviderInformation {

  final String imageUrl;
  final String name;
  final String occupation;
  final int experience;
  final String location;
  final String serviceProviderDocID;
  final List<double> ratings = [5];
  final double currentRating;
  final String uid;

  ServiceProviderInformation(this.imageUrl, this.name, this.occupation, this.experience, this.location, this.serviceProviderDocID, rating, this.currentRating, this.uid);


  static Future<List<ServiceProviderInformation>> getServiceProviderInformation(String occupation) async
  {
    List<ServiceProviderInformation> serviceProviderInformation = [];
    try{

      var snapshot = await FirebaseFirestore.instance
          .collection('serviceProviderInfo')
          .where('Occupation', isEqualTo: occupation)
          .get();

     for(var currentDoc in snapshot.docs)
       {
         ServiceProviderInformation obj = ServiceProviderInformation(currentDoc['imageUrl'], currentDoc['Name'], currentDoc['Occupation'], currentDoc['Experience'], currentDoc['Location'],currentDoc.id, currentDoc['Ratings'], currentDoc['currentRating'].toDouble(), currentDoc['uid']);
         serviceProviderInformation.add(obj);
       }
    }
    catch(e)
    {
      //print(e)
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
    double currentRating = calculateRating(obj.ratings);
    return {
      'imageUrl': obj.imageUrl,
      'Name': obj.name,
      'Occupation': obj.occupation,
      'Experience': obj.experience,
      'serviceProviderDocID': obj.serviceProviderDocID,
      'Location': obj.location,
      'Ratings': obj.ratings,
      'currentRating': currentRating
    };
  }

  double calculateRating(List<double> ratings)
  {
     double sum = ratings.reduce((a, b) => a + b);
     return sum/ratings.length;
  }
}