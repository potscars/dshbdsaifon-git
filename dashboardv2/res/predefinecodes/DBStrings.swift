//
//  DBStrings.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 08/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBStrings: NSObject {
    
    static let DB_FULL_APPNAME: String = "Dashboard Komuniti Kota Belud (IOS)"
    
    // General
    static let DB_BUTTON_BACK_LABEL_EN: String = "Back"
    static let DB_BUTTON_BACK_LABEL_MS: String = "Kembali"
    static let DB_BUTTON_OK_LABEL_EN: String = "OK"
    static let DB_BUTTON_OK_LABEL_MS: String = "OK"
    static let DB_BUTTON_CANCEL_LABEL_EN: String = "Cancel"
    static let DB_BUTTON_CANCEL_LABEL_MS: String = "Batal"
    static let DB_BUTTON_CONFIRM_LABEL_EN: String = "Confirm"
    static let DB_BUTTON_CONFIRM_LABEL_MS: String = "Pasti"
    static let DB_BUTTON_RETRY_LABEL_EN: String = "Retry"
    static let DB_BUTTON_RETRY_LABEL_MS: String = "Semula"
    
    // Registration
    static let DB_USER_REG_SUCCESS_TITLE_EN: String = "Successfully Registered"
    static let DB_USER_REG_SUCCESS_TITLE_MS: String = "Berjaya didaftarkan"
    static let DB_USER_REG_SUCCESS_DESC_EN: String = "Now you are ready to login with your registered account. Thank you."
    static let DB_USER_REG_SUCCESS_DESC_MS: String = "Anda kini boleh melog masuk menggunakan akaun anda yang telah didaftarkan. Terima kasih."
    static let DB_USER_REG_FB_SUCCESS_TITLE_EN: String = "Successfully Registered"
    static let DB_USER_REG_FB_SUCCESS_TITLE_MS: String = "Berjaya didaftarkan"
    static let DB_USER_REG_FB_SUCCESS_DESC_EN: String = "Your FB account is registered. Thank you."
    static let DB_USER_REG_FB_SUCCESS_DESC_MS: String = "Akaun FB anda berjaya didaftarkan. Terima kasih."
    static let DB_USER_REG_FAILED_TITLE_EN: String = "Registration Failed"
    static let DB_USER_REG_FAILED_TITLE_MS: String = "Pendaftaran Gagal"
    static let DB_USER_REG_FAILED_DESC_EN: String = "Please try again later. If problem persist, please contact us."
    static let DB_USER_REG_FAILED_DESC_MS: String = "Sila cuba sebentar lagi. Jika masalah masih lagi berlaku, sila hubungi kami."
    static let DB_USER_REG_FB_FAILED_TITLE_EN: String = "Registration Failed"
    static let DB_USER_REG_FB_FAILED_TITLE_MS: String = "Pendaftaran Gagal"
    static let DB_USER_REG_FB_FAILED_DESC_EN: String = "Please try again later. If problem persist, please contact us."
    static let DB_USER_REG_FB_FAILED_DESC_MS: String = "Sila cuba sebentar lagi. Jika masalah masih lagi berlaku, sila hubungi kami."
    static let DB_USER_REG_PASSWORD_UNMATCHED_TITLE_EN: String = "Password Unmatched"
    static let DB_USER_REG_PASSWORD_UNMATCHED_TITLE_MS: String = "Kata Laluan Tidak Sama"
    static let DB_USER_REG_PASSWORD_UNMATCHED_DESC_EN: String = "Please make sure that your both password field are same value."
    static let DB_USER_REG_PASSWORD_UNMATCHED_DESC_MS: String = "Sila pastikan kedua-dua medan kata laluan anda adalah sama isinya."
    static let DB_USER_REG_FIELD_ZERO_TITLE_EN: String = "Field is required"
    static let DB_USER_REG_FIELD_ZERO_TITLE_MS: String = "Medan ini Diwajibkan"
    static let DB_USER_REG_FIELD_ZERO_FULLNAME_EN: String = "Please insert your Full Name."
    static let DB_USER_REG_FIELD_ZERO_FULLNAME_MS: String = "Sila masukkan Nama Penuh anda."
    static let DB_USER_REG_FIELD_ZERO_IC_EN: String = "Please insert your User ID."
    static let DB_USER_REG_FIELD_ZERO_IC_MS: String = "Sila masukkan ID Pengguna."
    static let DB_USER_REG_FIELD_ZERO_EMAIL_EN: String = "Please insert your Email."
    static let DB_USER_REG_FIELD_ZERO_EMAIL_MS: String = "Sila masukkan Emel anda."
    static let DB_USER_REG_FIELD_ZERO_PASSWORD_EN: String = "Please insert your password."
    static let DB_USER_REG_FIELD_ZERO_PASSWORD_MS: String = "Sila masukkan kata laluan anda."
    static let DB_USER_REG_FIELD_ZERO_CONFIRM_PASSWORD_EN: String = "Please insert your confirmed password."
    static let DB_USER_REG_FIELD_ZERO_CONFIRM_PASSWORD_MS: String = "Sila masukkan kata laluan anda yang pasti."
    static let DB_USER_REG_FB_FIELD_ZERO_FILL_IC_TITLE_EN: String = "Required"
    static let DB_USER_REG_FB_FIELD_ZERO_FILL_IC_TITLE_MS: String = "Diperlukan"
    static let DB_USER_REG_FB_FIELD_ZERO_FILL_IC_DESC_EN: String = "Please insert your preferred User ID. For your information, this User ID will be used as your identity in this app and will be stored for reference purposes. See our Privacy Policy."
    static let DB_USER_REG_FB_FIELD_ZERO_FILL_IC_DESC_MS: String = "Sila masukkan ID Pengguna pilihan anda. Untuk makluman, ID Pengguna akan digunakan sebagai identiti anda dalam aplikasi ini dan disimpan sebagai rujukan. Sila lihat Polisi Peribadi kami."
    static let DB_USER_REG_FB_FIELD_ZERO_CONFIRM_IC_TITLE_EN: String = "Confirmation"
    static let DB_USER_REG_FB_FIELD_ZERO_CONFIRM_IC_TITLE_MS: String = "Kepastian"
    static let DB_USER_REG_FB_FIELD_ZERO_PLACEHOLDER_IC_TITLE_EN: String = "Your preferred User ID"
    static let DB_USER_REG_FB_FIELD_ZERO_PLACEHOLDER_IC_TITLE_MS: String = "ID Pengguna pilihan"
    static let DB_USER_REG_FB_FIELD_ZERO_CONFIRM_IC_DESC_EN: String = "Please confirmed your User ID:"
    static let DB_USER_REG_FB_FIELD_ZERO_CONFIRM_IC_DESC_MS: String = "ID Pengguna ini akan digunakan sebagai identiti anda didalam aplikasi ini. Sila sahkan ID Pengguna anda:"
    static let DB_USER_REG_FIELD_PLACEHOLDER_USERNAME_EN: String = "Preferred User ID"
    static let DB_USER_REG_FIELD_PLACEHOLDER_USERNAME_MS: String = "ID Pengguna pilihan"
    static let DB_USER_REG_FIELD_PLACEHOLDER_NAME_EN: String = "Name"
    static let DB_USER_REG_FIELD_PLACEHOLDER_NAME_MS: String = "Nama"
    static let DB_USER_REG_FIELD_PLACEHOLDER_EMAIL_EN: String = "Email Address"
    static let DB_USER_REG_FIELD_PLACEHOLDER_EMAIL_MS: String = "Alamat Emel"
    static let DB_USER_REG_FIELD_PLACEHOLDER_PASSWORD_EN: String = "Password"
    static let DB_USER_REG_FIELD_PLACEHOLDER_PASSWORD_MS: String = "Kata Laluan"
    static let DB_USER_REG_FIELD_PLACEHOLDER_CONFIRM_PASSWORD_EN: String = "Confirmed Password"
    static let DB_USER_REG_FIELD_PLACEHOLDER_CONFIRM_PASSWORD_MS: String = "Pengesahan Kata Laluan"
    
    // Tentang
    static let DB_APP_COPYRIGHT_EN: String = "Copyright © 2017 Ingeniworks Sdn. Bhd."
    static let DB_APP_COPYRIGHT_MS: String = "Hakcipta © 2017 Ingeniworks Sdn. Bhd."
    static let DB_APP_BUILDER_EN: String = "Built by Mobile Team Ingeniworks"
    static let DB_APP_BUILDER_MS: String = "Dibangunkan oleh Mobile Team Ingeniworks"
    static let DB_APP_VERSION_EN: String = "Version"
    static let DB_APP_VERSION_MS: String = "Versi"
    static let DB_APP_BUILDNO_EN: String = "Build No"
    static let DB_APP_BUILDNO_MS: String = "No. Binaan"
    
    
    // Tentang - Youtube Video Player
    static let DB_ABOUT_PLAYBACK_WARN_EN: String = "(Video playback will take significant data)"
    static let DB_ABOUT_PLAYBACK_WARN_MS: String = "(Memainkan video akan mengambil jumlah data yang banyak)"
    
    
    // Tentang - Info
    static let DB_ABOUT_INFO_TITLE_EN: String = "What is the Dashboard?"
    static let DB_ABOUT_INFO_TITLE_MS: String = "Apa itu Dashboard?"
    static let DB_ABOUT_INFO_DESC_EN: String = "Pi1M Komuniti Dashboard merupakan satu aplikasi khas yang dibina untuk kegunaan komuniti setempat di sekitar Pusat Internet 1Malaysia (PI1M). Ia mengambil kira keperluan komuniti setempat dari segi perhubungan, pembelajaran, perniagaan, kesihatan dan juga pentadbiran. Penggunaan aplikasi ini diharapkan dapat meningkatkan taraf sosio ekonomi setempat dan secara tidak langsung dapat merapatkan jurang digital antara komuniti bandar dengan luar bandar."
    static let DB_ABOUT_INFO_DESC_MS: String = "Pi1M Komuniti Dashboard merupakan satu aplikasi khas yang dibina untuk kegunaan komuniti setempat di sekitar Pusat Internet 1Malaysia (PI1M). Ia mengambil kira keperluan komuniti setempat dari segi perhubungan, pembelajaran, perniagaan, kesihatan dan juga pentadbiran. Penggunaan aplikasi ini diharapkan dapat meningkatkan taraf sosio ekonomi setempat dan secara tidak langsung dapat merapatkan jurang digital antara komuniti bandar dengan luar bandar."
    
    
    // Tetapan
    static let DB_SETTINGS_REMEMBERME_TITLE_EN: String = "Remember Me"
    static let DB_SETTINGS_REMEMBERME_TITLE_MS: String = "Ingat Saya"
    static let DB_SETTINGS_REMEMBERME_DESC_EN: String = "Allow on this application to remember your account everytime you are login to Dashboard Komuniti"
    static let DB_SETTINGS_REMEMBERME_DESC_MS: String = "Membenarkan aplikasi mengingati akaun anda setiap kali anda membuka Dashboard Komuniti ini"
    
    
    // Log masuk
    static let DB_LOGIN_TITLE_EN: String = "Login"
    static let DB_LOGIN_TITLE_MS: String = "Log Masuk"
    static let DB_LOGIN_IC_LABEL_EN: String = "User ID"
    static let DB_LOGIN_IC_LABEL_MS: String = "ID Pengguna"
    static let DB_LOGIN_PASSWORD_LABEL_EN: String = "Password"
    static let DB_LOGIN_PASSWORD_LABEL_MS: String = "Kata Laluan"
    static let DB_LOGIN_NEXT_BUTTON_EN: String = "Next"
    static let DB_LOGIN_NEXT_BUTTON_MS: String = "Seterusnya"
    static let DB_LOGIN_LOGIN_BUTTON_EN: String = "Login"
    static let DB_LOGIN_LOGIN_BUTTON_MS: String = "Log Masuk"
    static let DB_LOGIN_DESC_LABEL_EN: String = "Your User ID will be used as login to the app."
    static let DB_LOGIN_DESC_LABEL_MS: String = "ID Pengguna anda akan digunakan untuk log masuk akaun."
    static let DB_LOGIN_INSERT_USER_EN: String = "Please enter your User ID."
    static let DB_LOGIN_INSERT_USER_MS: String = "Sila masukkan ID Pengguna anda."
    static let DB_LOGIN_INSERT_PASS_EN: String = "Please enter your password."
    static let DB_LOGIN_INSERT_PASS_MS: String = "Sila masukkan kata laluan anda."
    
    
    // Proses log masuk
    static let DB_PROCESS_TITLE_EN: String = "Login Processing"
    static let DB_PROCESS_TITLE_MS: String = "Memproses Log Masuk"
    static let DB_PROCESS_ERROR_TITLE_EN: String = "Error"
    static let DB_PROCESS_ERROR_TITLE_MS: String = "Masalah"
    static let DB_PROCESS_ERROR_DESC_EN: String = "Please check your User ID and/or your password."
    static let DB_PROCESS_ERROR_DESC_MS: String = "Sila periksa ID Pengguna dan/atau kata laluan anda."
    static let DB_PROCESS_FB_LOGIN_ERROR_TITLE_EN: String = "Error"
    static let DB_PROCESS_FB_LOGIN_ERROR_TITLE_MS: String = "Masalah"
    static let DB_PROCESS_FB_LOGIN_ERROR_DESC_EN: String = "There are errors while login using Facebook. Please try again."
    static let DB_PROCESS_FB_LOGIN_ERROR_DESC_MS: String = "Terdapat masalah sewaktu melog masuk menggunakan Facebook. Sila cuba sekali lagi."
    static let DB_PROCESS_FB_REG_CANCEL_ERROR_TITLE_EN: String = "Sorry"
    static let DB_PROCESS_FB_REG_CANCEL_ERROR_TITLE_MS: String = "Harap Maaf"
    static let DB_PROCESS_FB_REG_CANCEL_ERROR_DESC_EN: String = "To login using FB, User ID is required."
    static let DB_PROCESS_FB_REG_CANCEL_ERROR_DESC_MS: String = "Untuk log masuk menggunakan FB, ID Pengguna adalah diperlukan."

    
    // Login Selector
    static let DB_SELECT_USERNAME_EN: String = "Login with User ID"
    static let DB_SELECT_USERNAME_MS: String = "Log Masuk Dengan ID Pengguna"
    static let DB_SELECT_REGISTER_EN: String = "Login Register"
    static let DB_SELECT_REGISTER_MS: String = "Daftar Masuk"
    
    
    // Nama menu
    static let DB_MENU_MYKOMUNITI_EN: String = "MyKomuniti"
    static let DB_MENU_MYKOMUNITI_MS: String = "MyKomuniti"
    static let DB_MENU_SAIFON_EN: String = "S.A.I.F.O.N."
    static let DB_MENU_SAIFON_MS: String = "S.A.I.F.O.N."
    static let DB_MENU_MYSOAL_EN: String = "MySoal"
    static let DB_MENU_MYSOAL_MS: String = "MySoal"
    static let DB_MENU_MYSKOOL_EN: String = "MySkool"
    static let DB_MENU_MYSKOOL_MS: String = "MySkool"
    static let DB_MENU_MYHEALTH_EN: String = "MyHealth"
    static let DB_MENU_MYHEALTH_MS: String = "MyHealth"
    static let DB_MENU_MYSHOP_EN: String = "MyShop"
    static let DB_MENU_MYSHOP_MS: String = "MyShop"
    static let DB_MENU_WATERLEVEL_EN: String = "Water Level Rivers"
    static let DB_MENU_WATERLEVEL_MS: String = "Paras Air Sungai"
    static let DB_MENU_WEATHER_EN: String = "Weather"
    static let DB_MENU_WEATHER_MS: String = "Cuaca"
    static let DB_MENU_MYPLACE_EN: String = "MyPlace"
    static let DB_MENU_MYPLACE_MS: String = "MyPlace"
    
    //MyKomuniti Label
    static let DB_MODULE_MYKOMUNITI_PUBLIC_TAB_EN: String = "PUBLIC"
    static let DB_MODULE_MYKOMUNITI_PUBLIC_TAB_MS: String = "AWAM"
    static let DB_MODULE_MYKOMUNITI_ADMIN_TAB_EN: String = "ADMINISTRATION"
    static let DB_MODULE_MYKOMUNITI_ADMIN_TAB_MS: String = "PENTADBIRAN"
    static let DB_MODULE_MYKOMUNITI_LOADMORE_IDLE_EN: String = "Tap to load more"
    static let DB_MODULE_MYKOMUNITI_LOADMORE_IDLE_MS: String = "Tekan untuk memuatkan lagi"
    static let DB_MODULE_MYKOMUNITI_LOADMORE_PROCESSING_EN: String = "Please wait..."
    static let DB_MODULE_MYKOMUNITI_LOADMORE_PROCESSING_MS: String = "Sila tunggu..."
    static let DB_MODULE_MYKOMUNITI_MSG_PLACEHOLDER_EN: String = "Insert your message here..."
    static let DB_MODULE_MYKOMUNITI_MSG_PLACEHOLDER_MS: String = "Masukkan pesanan anda disini..."
    static let DB_MODULE_MYKOMUNITI_MSG_SEND_EN: String = "Send"
    static let DB_MODULE_MYKOMUNITI_MSG_SEND_MS: String = "Hantar"
    
    
    //MySoal Label
    static let DB_MODULE_MYSOAL_LOADMORE_IDLE_EN: String = "Tap to load more"
    static let DB_MODULE_MYSOAL_LOADMORE_IDLE_MS: String = "Tekan untuk memuatkan lagi"
    static let DB_MODULE_MYSOAL_LOADMORE_PROCESSING_EN: String = "Please wait..."
    static let DB_MODULE_MYSOAL_LOADMORE_PROCESSING_MS: String = "Sila tunggu..."
    
    
    //MySkool Label
    
    //MyHealth BP Label
    static let DB_MODULE_MYHEALTH_BP_CONDITION_OPTIMAL_EN: String = "Optimum"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_OPTIMAL_MS: String = "Baik"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_NORMAL_EN: String = "Normal"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_NORMAL_MS: String = "Biasa"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_HINORMAL_EN: String = "High-Normal"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_HINORMAL_MS: String = "Tinggi"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G1_EN: String = "Hypertension Grade 1"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G1_MS: String = "Darah Tinggi Gred 1"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G2_EN: String = "Hypertension Grade 2"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_HYPER_G2_MS: String = "Darah Tinggi Gred 2"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_UNKNOWN_EN: String = "Unidentified"
    static let DB_MODULE_MYHEALTH_BP_CONDITION_UNKNOWN_MS: String = "Tidak Diketahui"
    static let DB_MODULE_MYHEALTH_BP_ADVICE_OPTIMAL_EN: String = "Congratulations on having blood pressure numbers that are within the normal (optimal) range of less than 120/80 mm Hg. Keep up the good work and stick with heart-healthy habits like following a balanced diet and getting regular exercise."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_OPTIMAL_MS: String = "Tahniah kerana anda mempunyai nilai tekanan darah dalam lingkungan Baik/Normal iaitu kurang dari 120/80 mmHg. Teruskan usaha baik anda dan kekalkan gaya hidup yang sihat seperti mengamalkan pemakanan seimbang dan sentiasa melakukan senaman."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_NORMAL_EN: String = "Congratulations on having blood pressure numbers that are within the normal (optimal) range of less than 120/80 mm Hg. Keep up the good work and stick with heart-healthy habits like following a balanced diet and getting regular exercise."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_NORMAL_MS: String = "Tahniah kerana anda mempunyai nilai tekanan darah dalam lingkungan Baik/Normal iaitu kurang dari 120/80 mmHg. Teruskan usaha baik anda dan kekalkan gaya hidup yang sihat seperti mengamalkan pemakanan seimbang dan sentiasa melakukan senaman."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_HINORMAL_EN: String = "Your blood pressure is on Prehypertension level. Prehypertension is when blood pressure is consistently ranging from 120-139/80-89 mm Hg. People with prehypertension are likely to develop high blood pressure unless steps are taken to control it."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_HINORMAL_MS: String = "Tekanan darah anda berada di tahap Pra-Darah Tinggi. Pra-Darah Tinggi adalah apabila tekanan darah anda berada dalam lingkungan 120-139/80-89 mmHg secara konsisten. Orang yang mempunyai keadaan darah seperti ini mungkin akan menyebabkan peningkatan tekanan darah tinggi sehingga langkah pencegahan diambil."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_HYPER_G1_EN: String = "Hypertension Stage 1 is when blood pressure is consistently ranging from 140-159/90-99 mm Hg. At this stage of high blood pressure, doctors are likely to prescribe lifestyle changes and may consider adding blood pressure medication."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_HYPER_G1_MS: String = "Hipertensi Tahap 1 adalah apabila tekanan darah anda berada dalam lingkungan 140-159/90-99 mmHg secara konsisten. Pada tahap keadaan ini, biasanya doktor akan memberikan tatacara pengubahan gaya hidup dan mungkin mempertimbangkan rawatan darah tinggi kepada anda."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_HYPER_G2_EN: String = "Hypertension Stage 2 is when blood pressure is consistently ranging at levels greater than 160/100 mm Hg. At this stage of high blood pressure, doctors are likely to prescribe a combination of blood pressure medications along with lifestyle changes."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_HYPER_G2_MS: String = "Hipertensi Tahap 1 adalah apabila tekanan darah anda berada dalam lingkungan 160/100 mmHg atau lebih tinggi secara konsisten. Pada tahap keadaan ini, biasanya doktor akan memberikan tatacara pengubahan gaya hidup beserta dengan rawatan darah tinggi kepada anda."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_UNKNOWN_EN: String = "Your blood pressure status is unknown. Please consult the doctor for more information."
    static let DB_MODULE_MYHEALTH_BP_ADVICE_UNKNOWN_MS: String = "Keadaan tekanan darah anda tidak diketahui. Sila hubungi doktor untuk sebarang maklumat."
    
    
    //MyHealth BW Label
    static let DB_MODULE_MYHEALTH_BW_CONDITION_UNDERWEIGHT_EN: String = "Underweight"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_UNDERWEIGHT_MS: String = "Kurang Berat"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_HEALTHYWEIGHT_EN: String = "Healthy Weight"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_HEALTHYWEIGHT_MS: String = "Berat Ideal"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_OVERWEIGHT_EN: String = "Overweight"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_OVERWEIGHT_MS: String = "Terlebih Berat"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_OBESE_EN: String = "Obese"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_OBESE_MS: String = "Obes"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_SEVEREOBESE_EN: String = "Severe Obese"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_SEVEREOBESE_MS: String = "Obes Yang Teruk"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_MORBIDLYOBESE_EN: String = "Morbidly Obese"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_MORBIDLYOBESE_MS: String = "Obes Melampau"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_UNKNOWN_EN: String = "Unidentified"
    static let DB_MODULE_MYHEALTH_BW_CONDITION_UNKNOWN_MS: String = "Tidak Diketahui"
    static let DB_MODULE_MYHEALTH_BW_ADVICE_UNDERWEIGHT_EN: String = "Being underweight could be a sign that you're not eating enough or that you may be ill. If you're underweight, consult any general practitioners which can help yours."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_UNDERWEIGHT_MS: String = "Menjadi seorang yang kurang berat badan adalah menunjukkan gejala yang anda kurang mengambil pemakanan atau anda mungkin menghadapi penyakit. Jika anda seperti ini, sila berhubung dengan pakar berkaitan yang boleh membantu anda."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_HEALTHYWEIGHT_EN: String = "Keep up the good work."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_HEALTHYWEIGHT_MS: String = "Teruskan usaha baik anda."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_OVERWEIGHT_EN: String = "The best way to lose weight is through a combination of diet and exercise."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_OVERWEIGHT_MS: String = "Cara yang terbaik untuk mengurangkan berat badan adalah dengan membuat gabungan diet dan senaman."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_OBESE_EN: String = "The best way to lose weight is through a combination of diet and exercise and in some cases medication. Contact your GP for help and advice."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_OBESE_MS: String = "Cara yang terbaik untuk mengurangkan berat badan adalah dengan melakukan gabungan pemakanan sihat dan bersenam, dan mungkin nasihat perubatan. Sila hubungi pakar berkaitan untuk nasihat dan bantuan."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_SEVEREOBESE_EN: String = "The best way to lose weight is through a combination of diet and exercise and in some cases medication. Contact your GP for help and advice."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_SEVEREOBESE_MS: String = "Cara yang terbaik untuk mengurangkan berat badan adalah dengan melakukan gabungan pemakanan sihat dan bersenam, dan mungkin nasihat perubatan. Sila hubungi pakar berkaitan untuk nasihat dan bantuan."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_MORBIDLYOBESE_EN: String = "The best way to lose weight is through a combination of diet and exercise and in some cases medication. Contact your GP for help and advice."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_MORBIDLYOBESE_MS: String = "Cara yang terbaik untuk mengurangkan berat badan adalah dengan melakukan gabungan pemakanan sihat dan bersenam, dan mungkin nasihat perubatan. Sila hubungi pakar berkaitan untuk nasihat dan bantuan."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_UNKNOWN_EN: String = "Your body weight BMI is unknown. Please consult the doctor for more information."
    static let DB_MODULE_MYHEALTH_BW_ADVICE_UNKNOWN_MS: String = "Keadaan BMI berat badan anda tidak diketahui. Sila hubungi doktor untuk sebarang maklumat."
    static let DB_MODULE_MYHEALTH_BW_WEIGHT_UNIT_SHORT_EN: String = "Kg"
    static let DB_MODULE_MYHEALTH_BW_WEIGHT_UNIT_SHORT_MS: String = "Kg"
    static let DB_MODULE_MYHEALTH_BW_WEIGHT_UNIT_EN: String = "Kilogram"
    static let DB_MODULE_MYHEALTH_BW_WEIGHT_UNIT_MS: String = "Kilogram"
    static let DB_MODULE_MYHEALTH_BW_BMI_POINT_EN: String = "point"
    static let DB_MODULE_MYHEALTH_BW_BMI_POINT_MS: String = "mata"
    
    
    //MyPlace
    
    //Settings
    static let DB_APP_SETTINGS_REMEMBER_ME_TITLE_EN: String = "Remember Me"
    static let DB_APP_SETTINGS_REMEMBER_ME_TITLE_MS: String = "Ingat Saya"
    static let DB_APP_SETTINGS_REMEMBER_ME_DESC_EN: String = "Allows this app to remember your login, thus will no need to relogin each time you reopen this app."
    static let DB_APP_SETTINGS_REMEMBER_ME_DESC_MS: String = "Membenarkan aplikasi ini mengingati akaun log masuk anda, sekaligus tidak memerlukan anda log masuk semula setiap kali membuka aplikasi ini."
    static let DB_APP_SETTINGS_LOGOUT_TITLE_EN: String = "Logout"
    static let DB_APP_SETTINGS_LOGOUT_TITLE_MS: String = "Log Keluar"
    static let DB_APP_SETTINGS_LOGOUT_MESSAGE_EN: String = "Are you sure want to logout?"
    static let DB_APP_SETTINGS_LOGOUT_MESSAGE_MS: String = "Anda pasti ingin log keluar?"
    
}
