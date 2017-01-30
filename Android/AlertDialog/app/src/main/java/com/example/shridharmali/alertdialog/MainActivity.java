package com.example.shridharmali.alertdialog;

import android.content.DialogInterface;
import android.support.v4.app.FragmentActivity;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

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
