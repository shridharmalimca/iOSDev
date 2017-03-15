package com.example.shridharmali.appointment;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.HashMap;
import java.util.Map;

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

/*
    LOGIN USER WITH USERNAME AND PASSWORD // CALLING WEB SERVICE HERE.
    public class LoginUser extends AsyncTask {

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected void onPostExecute(Object o) {
            super.onPostExecute(o);
        }

        @Override
        protected Object doInBackground(Object[] params) {
            RequestQueue queue = Volley.newRequestQueue(getApplicationContext());
            String url = "";
            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    Toast.makeText(getApplicationContext(), response, Toast.LENGTH_LONG).show();
                    finish();

                    Intent appointmentIntent = new Intent(getApplicationContext(), MainActivity.class);
                    startActivity(appointmentIntent);
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    Toast.makeText(getApplicationContext(), error.getMessage(), Toast.LENGTH_LONG).show();
                }
            }){
                @Override
                protected Map<String, String> getParams() {
                    Map<String, String> params = new HashMap<String, String>();
                    params.put("", "");
                    params.put("", "");
                    return params;
                }
            };

            queue.add(stringRequest);
            return null;
        }
    }
    */
}
