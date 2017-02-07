package com.example.shridharmali.appointment;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

public class LoginActivity extends AppCompatActivity {
    public static final String loginPref = "appointment.login.sharedPref";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
    }

    public void loginUser(View v) {
        Toast.makeText(LoginActivity.this, "Login Clicked", Toast.LENGTH_SHORT).show();
        SharedPreferences loginSharedPref = getSharedPreferences(loginPref, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = loginSharedPref.edit();
        editor.putBoolean("isUserLoggedIn", true);
        editor.commit();
        finish();

        Intent appointmentIntent = new Intent(this, MainActivity.class);
        startActivity(appointmentIntent);

    }
}
