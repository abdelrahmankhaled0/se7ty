import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ty/core/services/fieebase/firebase_services.dart';
import 'package:se7ty/features/auth/data/models/doctor_model.dart';
import 'package:se7ty/features/patient/booking/data/model/booking_model.dart';
import 'package:se7ty/features/patient/booking/presentation/cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitialState());

  static BookingCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var patientNameControler = TextEditingController();
  var phoneControler = TextEditingController();
  var descreptionControler = TextEditingController();
  var dateControler = TextEditingController();

  late DoctorModel? model;

  createAppointment() async {
    try {
      var appointmentDate = AppointmentModel(
        patientID: FirebaseAuth.instance.currentUser?.uid ?? "",
        doctorID: model?.uid ?? "",
        name: patientNameControler.text,
        phone: phoneControler.text,
        description: descreptionControler.text,
        doctorName: model?.name ?? "",
        location: model?.address ?? "",
        date: dateControler.text,
        isComplete: false,
      );
      emit(BookingLoadingState());
      await FirebaseServices.createAppointment(appointmentDate);
      emit(BookingSuccessState());
    } on Exception catch (_) {
      emit(BookingErrorState());
    }
  }
}
