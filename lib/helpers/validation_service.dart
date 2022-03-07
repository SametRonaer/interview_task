import 'package:get/get.dart';

class ValidationService{

static String? checkEmail(String? value){
  if(GetUtils.isNullOrBlank(value)!){
    return "This area can't be empty !";
  }else if(!GetUtils.isEmail(value!)){
    return "Please check your email adress";
  }
}
static String? checkPassword(String? value){
  if(GetUtils.isNullOrBlank(value)!){
    return "This area can't be empty !";
  }
}


}