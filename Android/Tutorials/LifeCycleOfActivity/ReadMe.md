## Life cycle of "Activity"

![Life cycle of android activity](https://github.com/shridharmalimca/iOSDev/blob/master/Android/Tutorials/LifeCycleOfActivity/LifeCycle.png)


**onCreate()**

 - onCreate() method get called when activity is first created.
 
 ``` 
 @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.d("onCreate()", "onCreate Involved");
 }
 
 ```
 
 **onStart()**

- onStart() method get called when activity get visible to user
 
 ```
 @Override
    protected void onStart() {
        super.onStart();
        Log.d("onStart()", "onStart Involved");
    }
  
 ```
 **onResume()**
 
 - onResume() method will get called when activity start interacting with the user.

 ```
 @Override
    protected void onResume() {
        super.onResume();
        Log.d("onResume", "onResume Involved");
    }
 
 ```
 
 **onPause()**
 
 - onPause() method will get called when some other high prority app come in the foreground (like phone call), so that need memory to execute, so current activity will gets in the onPause state.

 ```
 @Override
    protected void onPause() {
        super.onPause();
        Log.d("onPause()", "onPause Involved");
    }
 ```
 
 **onStop()**
 
 - onStop() method will get called when activity no longer visible to the user.

 ```
 @Override
    protected void onStop() {
        super.onStop();
        Log.d("onStop", "onStop Involved");
    }
 
 ```
 
 **onRestart()**
 
 - onRestart() method will get calledn after activity get stopped and prior to start.

 ```
 @Override
    protected void onRestart() {
        super.onRestart();
        Log.d("onStop", "onStop Involved");
    }
 
 ```
 
 **onDestroy()** 
 
 - onDestroy() method wil get called before activity destroyed.

 ```
 @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d("onDestroy", "onDestroy Involved");
    }
 
 ```
 
 