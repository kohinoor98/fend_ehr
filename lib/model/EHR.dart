import 'Patient.dart';

class EHR extends Patient {

  EHR(
      {this.appoitmentComment,
      this.appoitmentDate,
      this.appoitmentTime,
      this.imgLink,
      this.patienSurname,
      this.patientName,
      this.phoneNumber})
      : super.named(patientName,imgLink,phoneNumber,patienSurname);

  String patientName, patienSurname, imgLink, phoneNumber;
  String appoitmentDate;
  String appoitmentTime;
  String appoitmentComment;
  bool isFuture;


}
