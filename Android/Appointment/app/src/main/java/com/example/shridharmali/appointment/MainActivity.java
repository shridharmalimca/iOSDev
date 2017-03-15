package com.example.shridharmali.appointment;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.nfc.Tag;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainActivity extends AppCompatActivity {
    public static final String loginPref = "appointment.login.sharedPref";
    private List<Patient> patientList = new ArrayList<>();
    private RecyclerView recyclerView;
    private PatientAdapter patientAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if(isValidUserLoggedIn() == true) {
            // Show main activity continue with patient list
            recyclerView = (RecyclerView)findViewById(R.id.recycler_view);


            RecyclerView.LayoutManager patientLayoutManager = new LinearLayoutManager(getApplicationContext());
            recyclerView.setLayoutManager(patientLayoutManager);
            recyclerView.setHasFixedSize(true);
            recyclerView.addItemDecoration(new DividerItemDecoration(this, LinearLayoutManager.VERTICAL));
            recyclerView.setItemAnimator(new DefaultItemAnimator());


            getPatientData();

        } else {
            // end current activity and start new activity for the login view
            finish();
            Intent loginIntent = new Intent(this, LoginActivity.class);
            startActivity(loginIntent);
        }
    }

    public Boolean isValidUserLoggedIn() {
        SharedPreferences loginSharedPref = getSharedPreferences(loginPref, Context.MODE_PRIVATE);
        Boolean isUserLoggedIn = loginSharedPref.getBoolean("isUserLoggedIn", false);
        if (isUserLoggedIn == false) {
            return false;
        } else {
            // Show main activity continue
            return true;
        }
    }

    public void getPatientData() {
        GetPatientData patientData = new GetPatientData();
        patientData.execute();

    }

    public void appPatient(View v) {
        Intent addAppointmentIntent = new Intent(this, AddAppointment.class);
        startActivity(addAppointmentIntent);
    }


    public class GetPatientData extends AsyncTask {

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
            String url = "http://technonnovations.in/api/PatientNotifications";

                    //"http://toscanyacademy.com/blog/mp.php";
            StringRequest stringRequest = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {

                @Override
                public void onResponse(String response) {
                    // Log.d("", "Response " + response);
                    Toast.makeText(getApplicationContext(), response, Toast.LENGTH_SHORT).show();
                    GsonBuilder builder = new GsonBuilder();
                    Gson mGson = builder.create();
                    patientList = Arrays.asList(mGson.fromJson(response, Patient[].class));
                    patientAdapter = new PatientAdapter(patientList);
                    recyclerView.setAdapter(patientAdapter);
                    patientAdapter.notifyDataSetChanged();
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    Log.d("", "Error " + error.getMessage());
                }
            }); /*{
                protected Map<String, String> getParams() {
                    Map<String, String> params = new HashMap<String, String>();
                    params.put("", "");
                    params.put("", "");
                    return params;
                }
            };*/

            queue.add(stringRequest);
            return null;
        }


    }


}
