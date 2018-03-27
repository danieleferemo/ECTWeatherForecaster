# ECTWeatherForecaster
An iOS Weather forecaster app with basic functionailty.

Answers to suggested questions.

1.) Which libraries or tools you decided to use and why

- JSONModel for parsing the Json data. I did this not just for convinience and to save time, but also to show use of 'CocoaPods' in my project.

2.)Any parts of the task that you found easy or difficult, or code that is tricky or needs explanation

- For background fetching every 20mins, I used the 'NSURLSessionDownloadDelegate' :URLSession:downloadTask:didFinishDownloadingToURL:. It's implementation is in the 
 ECTHTTPClientManager class. The necessary call to 'UIBackgroundFetchResult' is done in the VC where the call is instigated; 'ECTWeeklyForecastTVC'
- I used 'UNUserNotificationCenterDelegate' to schedule local notifications to be sent to the users when extreme temperatures are detected.
- Most reuseable / non-VC specific code have been placed in a helper class; 'ECTUtilityMethods'
- Application wide constants/variable like 'extreme weather temperature', 'minimum time between background fetches' are placed in the class; 'ECTAppConstants'
- Auto layout : Auto Layout Visual Format Language is used to achieve contraints in one of the custom cell (ECTWeeklyForecastCell), while the other custom cell 
  (ECTDailyForecastCell) constraints are achieved using Autolayout in the .xib file.
  
3.) How long did you estimate the task was going to take you at first, and how long did it actually take.

- I had set aside 3 half working days (after hours) for the task, but it ended up taking me just over 2 full working days.
