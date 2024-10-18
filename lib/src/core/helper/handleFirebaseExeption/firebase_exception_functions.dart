import 'package:firebase_auth/firebase_auth.dart';
import 'package:fwo_admin/src/core/helper/handleFirebaseExeption/firebase_exception_code.dart';
import 'package:get/get.dart';


Future<FirebaseExceptionCode?> handleFirebaseError(Future<void> Function() operation) async {
  try {
    await operation();
    return null; // No error
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return FirebaseExceptionCode.accountExistsWithDifferentCredential;
      case 'email-already-in-use'
          : return FirebaseExceptionCode.emailAlreadyInUse;
      case 'invalid-credential':
        return FirebaseExceptionCode.invalidCredential;
      case 'invalid-email':
        return FirebaseExceptionCode.invalidEmail;
      case 'invalid-verification-code':
        return FirebaseExceptionCode.invalidVerificationCode;
      case 'invalid-verification-id':
        return FirebaseExceptionCode.invalidVerificationId;
      case 'invalid-user-token':
        return FirebaseExceptionCode.invalidUserToken;
      case 'app-not-authorized':
        return FirebaseExceptionCode.appNotAuthorized;
      case 'app-not-installed':
        return FirebaseExceptionCode.appNotInstalled;
      case 'argument-error':
        return FirebaseExceptionCode.argumentError;
      case 'invalid-api-key':
        return FirebaseExceptionCode.invalidApiKey;
      case 'invalid-user-token':
        return FirebaseExceptionCode.invalidUserToken;
      case 'network-request-failed':
        return FirebaseExceptionCode.networkRequestFailed;
      case 'no-auth-event':
        return FirebaseExceptionCode.noAuthEvent;
      case 'operation-not-allowed':
        return FirebaseExceptionCode.operationNotAllowed;
      case 'requires-recent-login':
        return FirebaseExceptionCode.requiresRecentLogin;
      case 'too-many-requests':
        return FirebaseExceptionCode.tooManyRequests;
      case 'user-disabled':
        return FirebaseExceptionCode.userDisabled;
      case 'user-not-found':
        return FirebaseExceptionCode.userNotFound;
      case 'weak-password':
        return FirebaseExceptionCode.weakPassword;
      case 'wrong-password':
        return FirebaseExceptionCode.wrongPassword;
      default:
        print('Unknown error: ${e.code}');
        return FirebaseExceptionCode.unknown; // Unknown error
    }
  } on FirebaseException catch (e) {
    switch (e.code) {
      case 'cancelled':
        return FirebaseExceptionCode.cancelled;
      case 'invalid-argument':
        return FirebaseExceptionCode.invalidArgument;
      case 'deadline-exceeded':
        return FirebaseExceptionCode.deadlineExceeded;
      case 'not-found':
        return FirebaseExceptionCode.notFound;
      case 'already-exists':
        return FirebaseExceptionCode.alreadyExists;
      case 'permission-denied':
        return FirebaseExceptionCode.permissionDenied;
      case 'resource-exhausted':
        return FirebaseExceptionCode.resourceExhausted;
      case 'failed-precondition':
        return FirebaseExceptionCode.failedPrecondition;
      case 'aborted':
        return FirebaseExceptionCode.aborted;
      case 'out-of-range':
        return FirebaseExceptionCode.outOfRange;
      case 'unimplemented':
        return FirebaseExceptionCode.unimplemented;
      case 'internal':
        return FirebaseExceptionCode.internal;
      case 'unavailable':
        return FirebaseExceptionCode.unavailable;
      case 'data-loss':
        return FirebaseExceptionCode.dataLoss;
      case 'unauthenticated':
        return FirebaseExceptionCode.unauthenticated;
      case 'object-not-found':
        return FirebaseExceptionCode.objectNotFound;
      case 'bucket-not-found':
        return FirebaseExceptionCode.bucketNotFound;
      case 'project-not-found':
        return FirebaseExceptionCode.projectNotFound;
      case 'quota-exceeded':
        return FirebaseExceptionCode.quotaExceeded;
      case 'unauthorized':
        return FirebaseExceptionCode.unauthorized;
      case 'retry-limit-exceeded':
        return FirebaseExceptionCode.retryLimitExceeded;
      case 'invalid-checksum':
        return FirebaseExceptionCode.invalidChecksum;
      case 'canceled':
        return FirebaseExceptionCode.canceled;
      case 'invalid-event-name':
        return FirebaseExceptionCode.invalidEventName;
      case 'invalid-url':
        return FirebaseExceptionCode.invalidUrl;
      case 'transient-error':
        return FirebaseExceptionCode.transientError;
      case 'server-file-wrong-size':
        return FirebaseExceptionCode.serverFileWrongSize;
      default:
        print('**Unknown error: ${e.code}');
        return FirebaseExceptionCode.unknown; // Unknown error
    }
  } catch (e) {
    print('**Unknown error: $e');
    return FirebaseExceptionCode.unknown; // Other types of exceptions
  }
}

String getFirebaseErrorMessage(FirebaseExceptionCode? errorCode) {
  print('error code: $errorCode');
  switch (errorCode) {
    // Auth Exception Messages
    case FirebaseExceptionCode.accountExistsWithDifferentCredential:
      return "The account already exists with a different credential.".tr;
    case FirebaseExceptionCode.emailAlreadyInUse:
      return "The email is already in use by another account.".tr;
    case FirebaseExceptionCode.invalidCredential:
      return "The provided credential is invalid.".tr;
    case FirebaseExceptionCode.invalidEmail:
      return "The email address is badly formatted.".tr;
    case FirebaseExceptionCode.invalidVerificationCode:
      return "The credential verification code is invalid.".tr;
    case FirebaseExceptionCode.invalidVerificationId:
      return "The credential verification ID is invalid.".tr;
    case FirebaseExceptionCode.appNotAuthorized:
      return "The app is not authorized to use Firebase Authentication.".tr;
    case FirebaseExceptionCode.appNotInstalled:
      return "The app is not installed.".tr;
    case FirebaseExceptionCode.argumentError:
      return "An error occurred in the arguments provided.".tr;
    case FirebaseExceptionCode.invalidApiKey:
      return "The API key provided is invalid.".tr;
    case FirebaseExceptionCode.invalidUserToken:
      return "The user's credential is no longer valid.".tr;
    case FirebaseExceptionCode.networkRequestFailed:
      return "A network error occurred. Please check your internet connection.".tr;
    case FirebaseExceptionCode.noAuthEvent:
      return "No authentication event occurred.".tr;
    case FirebaseExceptionCode.operationNotAllowed:
      return "The specified operation is not allowed.".tr;
    case FirebaseExceptionCode.requiresRecentLogin:
      return "The operation requires a recent login. Please log in again.".tr;
    case FirebaseExceptionCode.tooManyRequests:
      return "Too many requests. Please try again later.".tr;
    case FirebaseExceptionCode.userDisabled:
      return "The user account has been disabled by an administrator.".tr;
    case FirebaseExceptionCode.userNotFound:
      return "No user found with the provided credentials.".tr;
    case FirebaseExceptionCode.weakPassword:
      return "The password is not strong enough. Please choose a stronger password.".tr;
    case FirebaseExceptionCode.wrongPassword:
      return "The password is incorrect. Please try again.".tr;

    // Firestore Exception Messages
    case FirebaseExceptionCode.cancelled:
      return "The operation was cancelled.".tr;
    case FirebaseExceptionCode.unknown:
      return "An unknown error occurred.".tr;
    case FirebaseExceptionCode.invalidArgument:
      return "An invalid argument was provided.".tr;
    case FirebaseExceptionCode.deadlineExceeded:
      return "The operation took too long to complete.".tr;
    case FirebaseExceptionCode.notFound:
      return "The requested document was not found.".tr;
    case FirebaseExceptionCode.alreadyExists:
      return "The document already exists.".tr;
    case FirebaseExceptionCode.permissionDenied:
      return "You do not have permission to perform this operation.".tr;
    case FirebaseExceptionCode.resourceExhausted:
      return "Resource limit has been exceeded.".tr;
    case FirebaseExceptionCode.failedPrecondition:
      return "The operation failed due to a precondition.".tr;
    case FirebaseExceptionCode.aborted:
      return "The operation was aborted.".tr;
    case FirebaseExceptionCode.outOfRange:
      return "The operation was attempted past the valid range.".tr;
    case FirebaseExceptionCode.unimplemented:
      return "The operation is not implemented.".tr;
    case FirebaseExceptionCode.internal:
      return "An internal error occurred.".tr;
    case FirebaseExceptionCode.unavailable:
      return "The service is currently unavailable. Please try again later.".tr;
    case FirebaseExceptionCode.dataLoss:
      return "Data loss occurred.".tr;
    case FirebaseExceptionCode.unauthenticated:
      return "You need to authenticate to perform this operation.".tr;

    // Storage Exception Messages
    case FirebaseExceptionCode.objectNotFound:
      return "No object found at the specified reference.".tr;
    case FirebaseExceptionCode.bucketNotFound:
      return "No bucket is configured for Firebase Storage.".tr;
    case FirebaseExceptionCode.projectNotFound:
      return "No project is configured for Firebase Storage.".tr;
    case FirebaseExceptionCode.quotaExceeded:
      return "The storage quota has been exceeded.".tr;
    case FirebaseExceptionCode.unauthorized:
      return "You do not have permission to perform this operation.".tr;
    case FirebaseExceptionCode.retryLimitExceeded:
      return "The operation took too long to complete. Please try again.".tr;
    case FirebaseExceptionCode.invalidChecksum:
      return "The file checksum does not match.".tr;
    case FirebaseExceptionCode.canceled:
      return "The operation was cancelled.".tr;
    case FirebaseExceptionCode.invalidEventName:
      return "An invalid event name was provided.".tr;
    case FirebaseExceptionCode.invalidUrl:
      return "The URL provided is invalid.".tr;
    case FirebaseExceptionCode.transientError:
      return "A transient error occurred. Please try again.".tr;
    case FirebaseExceptionCode.serverFileWrongSize:
      return "The file size on the server does not match the specified size.".tr;
    // Default case
    default:
      return "An unknown error occurred.".tr;
  }
}


