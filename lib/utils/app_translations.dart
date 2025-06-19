import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // English (default)
    'en_US': {
      'already_have_an_account': 'Already have an account?',
      'see_your_profile':
          'See your profile, your joined clubs and activities and chat with your favourite clubs',
      'login': 'Log In',
      'create_account': 'Create Account',
      'log_in_with_registered_email': 'Login with your registered email',
      'field_is_empty': "Field is empty",
      'enter_valid_email': 'Enter a valid email',
    },
  };
}
