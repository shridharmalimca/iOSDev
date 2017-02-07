package com.example.shridharmali.appointment;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;

import java.util.ArrayList;
import java.util.List;

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

            patientAdapter = new PatientAdapter(patientList);
            RecyclerView.LayoutManager patientLayoutManager = new LinearLayoutManager(getApplicationContext());
            recyclerView.setLayoutManager(patientLayoutManager);
            recyclerView.setHasFixedSize(true);
            recyclerView.addItemDecoration(new DividerItemDecoration(this, LinearLayoutManager.VERTICAL));
            recyclerView.setItemAnimator(new DefaultItemAnimator());
            recyclerView.setAdapter(patientAdapter);

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
        Patient patient = new Patient("Shridhar");
        patientList.add(patient);

        patient = new Patient("Anni");
        patientList.add(patient);

        patient = new Patient("Shri");
        patientList.add(patient);

        patientAdapter.notifyDataSetChanged();
    }

    public void appPatient(View v) {
        Intent addAppointmentIntent = new Intent(this, AddAppointment.class);
        startActivity(addAppointmentIntent);
    }



}
