This Test App has in-App purchase feature enable 

## 1. PRODUCT ON DEVELPMENT MODE
- First you need to create a file name Configuration on the project. This file is found on the "Other" section within the file directory, is named StoredKit ConfigurationFile. And here we can add all pruducts, services and/or subscription we wat to have available on our App. 
   REMINDERS:
   a. This file will work only for development, after finished development mode we need to specify our products, services and/or subscription on Apple Connect. 
   b. To allow on local development to work with in app purchaces, we need to edit our scheme. By clicking on the name of our app that is close to the emulator or device selection,select edit scheme, this will pupup a modal with biuld, run, test, and other options. Next, we click on run, and select the "options" tab and where it says StoreKit Configuration we select from none to Configuration.storekit. this is the file we created early on the first step. 
   c. when deploying to apple connect our build, this uption needs to be returned to none, thus the products, services and/or subscription will be spicified on apple connect. 
   

## 2. FOR MODELS, VIEWS AND VIEWMODELS
- We need to import StoreKit on our files in order to work we purchases. 
- VIEW MODEL. 
   a. we need to add on our view model all identifier for each of our products in order to work, as an array of strings.
