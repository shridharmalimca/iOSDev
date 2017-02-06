# AlertDialog

A AlertDialog can

- Show title 
- Show upto three(3) buttons
- Show list of items
- Show custom layout (We have to use DialogFragment as a container for dialog)

## Simple Alert Dialog
### In  activity_main.xml file 

```
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/activity_main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:paddingBottom="@dimen/activity_vertical_margin"
    android:paddingLeft="@dimen/activity_horizontal_margin"
    android:paddingRight="@dimen/activity_horizontal_margin"
    android:paddingTop="@dimen/activity_vertical_margin"
    tools:context="com.example.shridharmali.alertdialog.MainActivity">

    <Button
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Click"
        android:onClick="showAlert"
        />
</RelativeLayout>

```

### Import following packages in MainActivity.java

```
import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.view.View;
import android.widget.Toast;
```


In MainActivity.java

```
public void showAlert(View v) {
        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);
        alertDialogBuilder.setMessage("Are you sure want to delete?");
        alertDialogBuilder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Toast.makeText(MainActivity.this,"Yes button clicked", Toast.LENGTH_LONG).show();
            }
        });

        alertDialogBuilder.setNegativeButton("No", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Toast.makeText(MainActivity.this,"No button clicked", Toast.LENGTH_SHORT).show();
            }
        });

        AlertDialog alert = alertDialogBuilder.create();
        alert.show();
    }

```


### Output
![Output](https://github.com/shridharmalimca/iOSDev/blob/master/Android/Tutorials/Alerts/step.png)


## Alert dialog using fragment

Steps:
1) Right click and add new java class and name it ``` AlertFragment ``` 

2) Get code after create class.

``` 
public class AlertFragment extends DialogFragment {

}

``` 

3) Override onCreate method

``` @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
    
    return super.onCreateDialog(savedInstanceState);
    
 }
    
```
 
 4) Add Following code on onCreate() method for create AlertDialog
 
 ```
 AlertDialog.Builder builder =  new AlertDialog.Builder(getActivity());
        builder.setMessage("All fields are mandatory");
        builder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                 Toast.makeText(getActivity(),"Yes button clicked", Toast.LENGTH_LONG).show();
            }
        });

        builder.setNegativeButton("No", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                 Toast.makeText(getActivity(),"No button clicked", Toast.LENGTH_SHORT).show();
            }
        });

        AlertDialog alert = builder.create();
        return (alert);
 
 ```
 
 
 5) Come back to MainActivity.java do following changes. 
 
 Change ``` FragmentActivity  ``` on place of ``` AppCompatActivity ``` 
 
 ``` 

 public class MainActivity extends FragmentActivity {
 
 
 }
 
 ``` 
 
 6) MainActivity.java code 
 
 ```
 
 public class MainActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }


    public void showAlert(View v) {
    AlertFragment alert = new AlertFragment();
        alert.show(getSupportFragmentManager(), "Alert_Fragment");
    }
}
 
 
 ```
 

# Output
![AlertDialog using DialogFragment](https://github.com/shridharmalimca/iOSDev/blob/master/Android/Tutorials/Alerts/DialogFragment.png)


## Alert Dialog with list items

 


