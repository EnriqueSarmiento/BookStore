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

## 3. DEPLOY TO APPLE CONNECT  (NEED APPLE DEVELOPER LICENSE)

- 1. we update out project scheme from Configuration.sk to none. Basically we wil revert the chnge we made for development purpuses on Run. 
- 2. on you apple connect account go to Certificates, Identifiers & Profiles
   a. under Certificates we should already have both Development and Distributions certificates on out account. The last one, is the main iomportant becase will allow us to send to distribution. 
- 3. Go to identifiers and register a new one.
   a. specicy it is an App ID. Click netx
   b. specify it is wheter an app or app clip (here is app). Click next
   c. Add a description for the new app, the bundle ID is the bundleIdentifier on our xcode project (the one with com.) before this step you can modified as desired, after submission gets a bit messy. 
   f. Specify the capabilities for the app, as you scroll down you might see In-App Purcheses feature is already enable for the app (as default) so there is no need to added more capabilities, in case your app has more. Click next to save, after this the new identifier has been created
- 4. return to you appstore connect account, app section and create a new app.
   a. first specify the platform (IOS) and name, this should be unique
   b. specify a main language for you app. 
   c. specify the ID PACK. This is the identifier we have created in step 3. 
   d. specify the SKU, this is an unique identifier for us, should be unique of all of our app. could be anything you want. like app_1 .
   e. specify the users acces for the app, this may or may not restrict an app access in case you share you apple connect account with other users. by default select ilimited. 
   f. Click next
- 5. FOR IN APP PRUCHASES FEATURE (otherwise skip) ---> Go to in app pruchases o purchases option inside your app. 
   a. click on manage to redirect to a section where you can manage all your products, services and/or subscription. 
   b. Here you need to add the same products you specified on the StoreKit configiration file. WITH THE SAME VALUES to avoir errors on both name and product ID. 
   c. add the price. here we cannot specify a price for our items as we desired (unlike storekit configuration file), we need to select one from the dropdown list. We can specify as well the price for other currencies.
   d. You can specicy the language for each product, with its title and description and an image
   e. SUBMIT the information for testing or review. 
   f. click on save
   
   --- THEN NEED TO GO APP STORE PROMOTIONS ON THE SAME TAB IN APP PRUCHASES
   g. here we will see our items and might need more information (metadatos) but it is like a warning type. 
   h. returno to xcode and find you target project, click on capabilities tag and add In-App purchases. it is likey thta if you do not have a licese you will not see that capability. 
   i. Then, you can rebuild the app on the simulator. 
   j. if you wan to test this on a real device it will ask you for apple id, so in the sandbox section of user and access on you apple connect account you may create not real users with apple id and try the purchases. 
   
- 6. SEND TO DISTRIBUTION (CREATE A CERTIFICATE FOR DISTRIBUTION)
   a. on Certificates, Identifiers and Profiles check if you have already a distribution certificate. If not, click on the plus icon to create a new one. 
   b. specify the type of certificate (Apple distribution). Click Next
   c. after click next on teh last step, it will ask you to submit a Cerificate Signing Request (CSR). To Create this certificate YOU MUST HAVE A MAC. 
      * on you mac, go to spotlight and type for keys or llaveros (depending you machine language)
      * Then go to Certificate assistant (asistente para certificados), by clicking on the top left corner on the keys app. Then, click on "Ask for an authority certificate" (Solicitar un certificado de una autoridad de certificados). 
      * this will pupup a new window that will ask you email, name, the type and where will be stored the certificate. by default check to stored on you local disk. 
      * after save, will pupup a new modal with the name of the certificate and to assign the location to stored, such as Download, Documents, etc. select whatever you desire. 
      * Then return to apple connect store where you need to submit the certificate. After save, it will ask you if you want to download the new certificate, you can do it and saved on your local machine. 
      
- 7. Submit app icon on apple connect
   a. You uploaded from xcode on the assets section. 

- 8. Send to apple connect from XCODE. 
   a. First, remove the emolator and select "any ios device (arm64)". If you do not do so, you cannot send to distribution. 
   b. Under de product tab on xcode (top left corner), select "archive" and this will compile the entire project. After this is finished, will pupup a new window with the compiled version. KEEP IN MIND THAT IF AFTER THE FIRST COMPILED VERSION YOU MODIFIED SOMETHING ON THE PROYECT, YOU NEED TO GO TO THE PROJECT SETTINGS AND UPDATE BOTH BUILD VERSION AND COMPILED NUMBER, otherwise you may not be able to send to apple connect. 
   c. then, click on Distrubute app button, select app store connect. click next
   d. wait until all proccesses are finished and check the optiones you need. Click next
   e. then, will ask you if you want autamtic or manual signing, you can select automatic (easier). Click next, it will ask you for you machine password. 
   f. It will show you a breaf resume and click on upload button. 
   
- 9. Update/submit information on apple connect regarding app. 
   a. here we submit assets and images, as well as described information of the app. (Basically it is something needs to be manual and not with CI/CD)
   b. Important to add information for apple review, in case there is authentication you must submit s test user (already stored on your db if possible) to testers to review. On notes please give a lot of context and indications for the app so it is easier for testers to review. 
   c. Here you need to specify the compiled versition to send to distribution. 
   
   
   
   
   

   

   

