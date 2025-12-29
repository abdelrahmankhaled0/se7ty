import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ty/features/auth/data/models/doctor_model.dart';
import 'package:se7ty/features/auth/data/models/patient_model.dart';
import 'package:se7ty/features/auth/data/user_type_enum.dart';
import 'package:se7ty/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final bioController = TextEditingController();
  final adrressController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();

  String? specialization;
  String? urlImage;

  register({required UserTypeEnum userTypeEnum}) async {
    emit(AuthLoadingState());
    try {
      var credintial = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credintial.user;
      user?.updateDisplayName(usernameController.text);

      if (userTypeEnum == UserTypeEnum.doctor) {
        user?.updatePhotoURL("2");
        var model = DoctorModel(
          name: usernameController.text,
          email: emailController.text,
          uid: user?.uid,
        );
        await FirebaseFirestore.instance
            .collection('doctor')
            .doc(user?.uid)
            .set(model.toJson());
      } else if (userTypeEnum == UserTypeEnum.patient) {
        user?.updatePhotoURL("1");
        var model = PatientModel(
          name: usernameController.text,
          email: emailController.text,
          uid: user?.uid,
        );
        await FirebaseFirestore.instance
            .collection('patient')
            .doc(user?.uid)
            .set(model.toJson());
      }

      emit(AuthSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState(error: 'كلمة مرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState(error: 'هذا الحساب موجود بالفعل'));
      } else {
        emit(AuthErrorState(error: 'حدث خطأ غير متوقع'));
      }
    } catch (e) {
      emit(AuthErrorState(error: 'حدث خطأ غير متوقع'));
    }
  }

  login() async {
    emit(AuthLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      emit(AuthSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthErrorState(error: 'هذا الحساب غير موجود'));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState(error: 'كلمة مرور غير صحيحة'));
      } else {
        emit(
          AuthErrorState(error: 'البريد الإلكتروني أو كلمة المرور غير صحيحة'),
        );
      }
    }
  }

  updateDoctorData() async {
    var model = DoctorModel(
      address: adrressController.text,
      bio: bioController.text,
      closeHour: endTimeController.text,
      openHour: startTimeController.text,
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      uid: FirebaseAuth.instance.currentUser?.uid,
      specialization: specialization,
      image: urlImage,
    );
    try {
      emit(AuthLoadingState());
      await FirebaseFirestore.instance
          .collection('doctor')
          .doc(model.uid)
          .update(model.toUpdateData());
      emit(AuthSucessState());
    } on Exception catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
