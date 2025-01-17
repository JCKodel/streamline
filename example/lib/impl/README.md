This folder contains all the implementations of your app: code that use databases, network requests, packages that uses some hardware sensor or native API, etc.

Notice that this folder has the same structure as the `features` folder, so you can easily find the implementation code.

All code in this folder is to be considered "unsafe": they can throw exceptions (be by your mistake or something that you can't control, such as a network request that fails)

Also, each dependency has their own exceptions. For example: Firebase Auth has an `FirebaseAuthException` with a code "user-disabled" when the use is disabled. This is very unique to Firebase Auth, so we call it a Firebase Auth *domain*.

Your app cannot depend on domains that you don't own or control, so you'll have to translate that exception above to something your app can understand. In this case, your features folder for auth will contain a class like `UserDisabledResponse` that you sign in handler will understand. So, whenever you are using tests, or Firebase Auth, or Supabase Auth, or Auth0, doesn't matter: your feature will always receive an app-domain message meaning the user is disabled, no matter how your implementation deals with it.

> **NOTHING in this folder can be used by any other folder in your project!**