package com.example.shridharmali.alertdialog;

import android.content.DialogInterface;
import android.support.v4.app.FragmentActivity;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

public class MainActivity extends  FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }


    public void showSimpleAlert(View v) {
       /* AlertDialog.Builder alertBuilder = new AlertDialog.Builder(this);
        alertBuilder.setMessage("Are you sure want to delete?");
        alertBuilder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Toast.makeText(MainActivity.this, "Yes button clicked", Toast.LENGTH_SHORT).show();
            }
        });

        alertBuilder.setNegativeButton("NO", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Toast.makeText(MainActivity.this, "No button clicked", Toast.LENGTH_SHORT).show();
            }
        });

        AlertDialog alert = new alertBuilder.create();
        alert.show();
        */
    }

    public void dialogFragment(View v) {
        AlertFragment alert = new AlertFragment();
        alert.show(getSupportFragmentManager(), "Alert_Fragment");
    }

    public void listDialog(View v) {
        ListAlertFragmentDialog  listAlert = new ListAlertFragmentDialog();
        listAlert.show(getSupportFragmentManager(), "list_alert");
    }
}
