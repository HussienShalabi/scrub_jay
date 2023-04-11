import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Mylocale implements Translations{
  @override
  Map<String, Map<String, String>> get keys =>{
    "ar": {
      'Arabic':'العربية',
      'English':'english',
      "Admin main page": "صفحة الادمن الرئيسية",
      "driver\'s list" : "قائمة السائقين",
      'initial turn' : 'الدور الاولي',
      'today\'s trip' : 'رحل اليوم',
      'add admin': 'اضافة ادمن',
      'Confirm Drivers':'التاكد من السائقين',
      'delete account': 'حذف سائق',
      'phone: ': 'الرقم : ',
      'New Admin': 'اضافة ادمن جديد',
      'Add new admin' : 'اضافة ادمن جديد',
      'Please fill in the following information : ' : 'الرجاء تعبئة البيانات التالية:',
      'Is the admin a driver ?' : 'هل الادمن سائق؟',
      'Yes':'نعم','No':'لا',
      'First Name':'الاسم الاول',
      'Enter your first name':'ادخل اسمك الاول',
      'Last Name':'الاسم الاخير',
      'Enter your last name':'ادخل اسمك الاخير',
      "Mobile Number":"رقم الهاتف",
      "Enter your mobile number":"ادخل رقم هاتفك",
      "Enter a valid phone number":"ادخل رقم هاتف صحيح",
      "Password*":"كلمة مرور*",
      "Enter your password":"ادخل كلمة المرور الخاصة بك",
      "Please enter your password":"الرجاء ادخال كلمة مرور",
      "ReEnter Password*":"اعادة ادخال كلمة المرور*",
      "Add":"اضافة",      "OK":"نعم",

      "Delete a Driver":"حذف سائق",
      'Profile Page':'الصفحة الشخصية',
      'Change language':'تغيير اللغة',
      'Log out':'تسجيل الخروج',
      'Driver main page':'صفحة السائق الرئيسية',
      'make a trip':'البدء برحلة',
      'Driver\'s Turn':'دور السائقين',
      'show news':'احوال الطريق',
      "Booked passengers":"حجوزات الركاب",
      "name: ":"الاسم: ",
      "seats: ":"عدد المقاعد: ",
      "Location: ":"الموقع: ",
      'Start the trip':'بدء الرحلة',
      "Available Trips":"الرحل المتاحة",
      "driver name: ":"اسم السائق: ",
      "available seats: ":"المقاعد المتاحة: ",
      'Register as ...':'التسجيل ك ...',
      'passenger':'راكب',
      'Driver':'سائق',
      "I accept all terms and conditions.":"أوافق على جميع الشروط والأحكام.",
      'You need to accept terms and conditions':"أنت بحاجة إلى قبول الشروط والأحكام",
      "Register": "تسجيل",
      'Hello':'مرحبا',
      'Sign in into your account':'تسجيل الدخول الى حسابك',
      "Forgot your password?":"نسيت كلمة المرور؟",
      "Don\'t have an account? ":"ليس لديك حساب؟ ",
      'Create account':'انشاء حساب',
      'Sign In':'تسجيل الدخول',
      "User Information":"معلومات المستخدم",
      "About Me":"حول المستخدم",
      'Enter the phone number associated with your account.':'أدخل رقم الهاتف المرتبط بحسابك.',
      'We will send to you a verification code to check your authenticity.':'سوف نرسل لك رمز تحقق للتحقق من حسابك.',
      "phone can't be empty":"لا يمكن أن يكون رقم الهاتف المحمول فارغًا",
      "Send":"إرسال",
      "Remember your password? ":"هل تذكرت كلمة المرور الخاصة بك؟ ",
      'Verification':'عملية التحقق',
      'Enter the verification code we just sent to you .':'أدخل رمز التحقق الذي أرسلناه لك للتو.',
      "If you didn't receive a code! ":"إذا لم تتلقى رمز! ",
      'Resend':'إعادة إرسال',
      "Successful":"نجحت العملية",
      "Verification code resend successful.":"تمت إعادة إرسال رمز التحقق بنجاح.",
      "Verify":"تأكيد",

























    },
    "en": {
      'Arabic':'العربية',
      'English':'English',
      "Admin main page":"Admin main page",
      'driver\'s list' : 'driver\'s list',
      'initial turn' : 'initial turn',
      'today\'s trip' : 'today\'s trip',
      'add admin': 'add admin',
      'confirm Drivers':'confirm Drivers',
      'delete account': 'delete account',
      'phone: ' : 'phone: ',
      'New Admin': 'New Admin',
      'Add new admin' : 'Add new admin',
      'Please fill in the following information : ' : 'Please fill in the following information : ',
      'Is the admin a driver ?' : 'Is the admin a driver ?',
      'Yes':'Yes', 'No':'No',
      'First Name':'First Name',
      'Enter your first name':'Enter your first name',
      'Last Name':'Last Name',
      'Enter your last name':'Enter your last name',
      "Mobile Number":"Mobile Number",
      "Enter your mobile number":"Enter your mobile number",
      "Enter a valid phone number":"Enter a valid phone number",
      "Password*":"Password*",
      "Enter your password":"Enter your password",
      "Please enter your password":"Please enter your password",
      "ReEnter Password*":"ReEnter Password*",
      "Add":"Add",
      "Delete a Driver":"Delete a Driver",
      'Profile Page':'Profile Page',
      'Change language':'Change language',
      'Log out':'Log out',
      'Driver main page':'Driver main page',
      'make a trip':'make a trip',
      'Driver\'s Turn':'Driver\'s Turn',
      'show news':'show news',
      "Booked passengers":"Booked passengers",
      "name: ":"name: ",
      "seats: ":"seats: ",
      "Location: ":"Location: ",
      'Start the trip':'Start the trip',
      "Available Trips":"Available Trips",
      "driver name: ":"driver name: ",
      "available seats: ":"available seats: ",
      "OK":"OK",
      'Register as ...':'Register as ...',
      'passenger':'passenger',
      'Driver':'Driver',
      "I accept all terms and conditions.":"I accept all terms and conditions.",
      'You need to accept terms and conditions':'You need to accept terms and conditions',
      "Register": "Register",
      'Hello':'Hello',
      'Sign in into your account':'Sign in into your account',
      "Forgot your password?":"Forgot your password?",
      "Don\'t have an account? ":"Don\'t have an account? ",
      'Create account':'Create account',
      'Sign In':'Sign In',
      "User Information":"User Information",
      "About Me":"About Me",
      'Enter the phone number associated with your account.':'Enter the phone number associated with your account.',
      'We will send to you a verification code to check your authenticity.':'We will send to you a verification code to check your authenticity.',
      "phone can't be empty":"phone can't be empty",
      "Send":"Send",
      "Remember your password? ":"Remember your password? ",
      'Verification':'Verification',
      'Enter the verification code we just sent to you .':'Enter the verification code we just sent to you .',
      "If you didn't receive a code! ":"If you didn't receive a code! ",
      'Resend':'Resend',
      "Successful":"Successful",
      "Verification code resend successful.":"Verification code resend successful.",
      "Verify":"Verify",
    },
  };

}