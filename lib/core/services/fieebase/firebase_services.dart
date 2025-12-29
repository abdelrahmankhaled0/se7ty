import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ty/features/patient/booking/data/model/booking_model.dart';

class FirebaseServices {
  static CollectionReference<Map<String, dynamic>> doctorCollection =
      FirebaseFirestore.instance.collection('doctor');

  static Future<QuerySnapshot<Map<String, dynamic>>> orderdDoctorsByRating() {
    return doctorCollection.orderBy('rating', descending: true).get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>>
  getDoctorsWithSpecialization(String specialization) {
    return doctorCollection
        .where('specialization', isEqualTo: specialization)
        .get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getdoctorsWithSearch(
    String searchKey,
  ) {
    return doctorCollection.orderBy('name').startAt([searchKey]).endAt([
      '$searchKey\uf8ff',
    ]).get();
  }

  static CollectionReference<Map<String, dynamic>> appointMentCollection =
      FirebaseFirestore.instance.collection('appointment');

  static createAppointment(AppointmentModel appointmentData) {
    appointMentCollection.doc().set(appointmentData.toJson());
  }
}
