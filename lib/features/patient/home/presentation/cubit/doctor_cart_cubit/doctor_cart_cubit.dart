import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ty/core/services/fieebase/firebase_services.dart';
import 'package:se7ty/features/auth/data/models/doctor_model.dart';
import 'package:se7ty/features/patient/home/presentation/cubit/doctor_cart_cubit/doctor_cart_states.dart';

class DocCartCubit extends Cubit<DocCartStates> {
  DocCartCubit() : super(DocCartInitialState());

  static DocCartCubit get(context) => BlocProvider.of(context);

  final searchController = TextEditingController();

  List<DoctorModel> doctors = [];

  List<DoctorModel> specializedDoctors = [];

  List<DoctorModel> searchedDoctors = [];

  getDocData() async {
    emit(DocCartLoadingState());
    try {
      final snapShot = await FirebaseServices.orderdDoctorsByRating();

      doctors = snapShot.docs
          .map((doc) => DoctorModel.fromJson(doc.data()))
          .toList();

      emit(DocCartSuccessState());
    } on Exception catch (_) {
      emit(DocCartErrorState());
    }
  }

  getSpecalizedDoctorData(String specialization) async {
    emit(DocCartLoadingState());
    try {
      final snapShot = await FirebaseServices.getDoctorsWithSpecialization(
        specialization,
      );

      specializedDoctors = snapShot.docs
          .map((speDoc) => DoctorModel.fromJson(speDoc.data()))
          .toList();

      emit(DocCartSuccessState());
    } on Exception catch (_) {
      emit(DocCartErrorState());
    }
  }

  getdoctorsWithSearch(String searchKey) async {
    emit(DocCartLoadingState());
    try {
      final snapShot = await FirebaseServices.getdoctorsWithSearch(searchKey);

      searchedDoctors = snapShot.docs
          .map((doc) => DoctorModel.fromJson(doc.data()))
          .toList();

      emit(DocCartSuccessState());
    } on Exception catch (_) {
      emit(DocCartErrorState());
    }
  }
}
