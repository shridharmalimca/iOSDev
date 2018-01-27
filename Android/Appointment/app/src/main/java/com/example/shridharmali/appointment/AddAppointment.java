package com.example.shridharmali.appointment;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v4.app.DialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TimePicker;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static android.net.sip.SipErrorCode.TIME_OUT;


public class AddAppointment extends AppCompatActivity {

    private static final String TAG = "1";
    EditText patientName;
    EditText patientMobileNo;
    EditText patientEmailId;
    EditText patientAppointmentDate;
    EditText patientAppointmentTime;
    Calendar calendar = Calendar.getInstance();
    DatePicker datePicker;
    TimePicker timePicker;

    String createdDateUTC;
    String notificationDate;

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_appointment);
        findByIds();

        TextWatcher watch = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                // Toast.makeText(getApplicationContext(), "Called", Toast.LENGTH_SHORT).show();
                if (patientName.getText().toString().trim().length() > 0) {
                    patientName.setError(null);
                } else if (patientMobileNo.getText().toString().trim().length() > 0) {
                    patientMobileNo.setError(null);
                } else if (patientEmailId.getText().toString().trim().length() > 0) {
                    patientEmailId.setError(null);
                } else if (patientAppointmentDate.getText().toString().trim().length() > 0) {
                    patientAppointmentDate.setError(null);
                } else if (patientAppointmentTime.getText().toString().trim().length() > 0) {
                    patientAppointmentTime.setError(null);
                }
            }
        };

        patientAppointmentDate.setInputType(0);
        patientAppointmentTime.setInputType(0);

        patientName.addTextChangedListener(watch);
        patientMobileNo.addTextChangedListener(watch);
        patientEmailId.addTextChangedListener(watch);

    }

    public void findByIds() {
        patientName = (EditText) findViewById(R.id.patientName);
        patientMobileNo = (EditText) findViewById(R.id.patientMobile);
        patientEmailId = (EditText) findViewById(R.id.patientEmail);
        patientAppointmentDate = (EditText) findViewById(R.id.appointmentDate);
        patientAppointmentTime = (EditText) findViewById(R.id.appointmentTime);
    }

    public void selecteDate(View v) {
        // Date selection
        Toast.makeText(getApplicationContext(), "Select Date", Toast.LENGTH_SHORT).show();
        DialogFragment datePicker = new DatePickerFragment();
        datePicker.show(getSupportFragmentManager(), "datePicker");

    }

    public void getSelectedDate(DatePicker view) {
        datePicker = view;
        int   day  = view.getDayOfMonth();
        int   month= view.getMonth();
        int   year = view.getYear() - 1900;

        String formatedDate = sdf.format(new Date(year, month, day));
        patientAppointmentDate.setText(formatedDate);
    }

    public void selecteTime(View v) {
        // Time selection
        if (patientAppointmentDate.getText().toString().trim().length() == 0) {
            patientAppointmentDate.setError("Please select date first");
            return;
        }
        DialogFragment timePicker = new TimePickerFragment();
        timePicker.show(getSupportFragmentManager(),"timePicker");
    }

    public void getSelectedTime(String time, TimePicker view) {
        timePicker = view;
        patientAppointmentTime.setText(time);
        calendar.set(datePicker.getYear(), datePicker.getMonth(), datePicker.getDayOfMonth(),
                timePicker.getHour(), timePicker.getMinute(), 0);
        long startTime = calendar.getTimeInMillis();
        // Log.d(TAG, "/Date(" + startTime + ")/");
        notificationDate = "/Date(" + startTime + ")/";
        Toast.makeText(getApplicationContext(), "" + startTime, Toast.LENGTH_LONG).show();
    }

    /* http://technonnovations.in/api/PatientNotifications
        {
        "NotificationId":0,
        "PatientName":"Abcd",
        "PhoneNumber":"8778979909",
        "CreatedDateUtc":"\/Date(1310669017000)\/",
        "NotificationDate":"\/Date(1310669017000)\/",
        "Status":1
        }
        */

    public void confirm(View v) {
        createdDateUTC = getCurrentDateInMilliSeconds();
        Log.d(TAG, "mills" + createdDateUTC);
       /* if (patientName.getText().toString().trim().length() == 0  &&
                patientMobileNo.getText().toString().trim().length() == 0 &&
                patientEmailId.getText().toString().trim().length() == 0 &&
                patientAppointmentDate.getText().toString().trim().length() == 0) {
            Toast.makeText(getApplicationContext(), "All Fields are mandatory", Toast.LENGTH_SHORT).show();

        } else*/ if (patientName.getText().toString().trim().length() == 0) {
            patientName.setError("Please enter valid name");
        } else if (patientMobileNo.getText().toString().trim().length() == 0) {
            patientMobileNo.setError("Please enter valid mobile number");
        } else if (patientEmailId.getText().toString().trim().length() == 0) {
            patientEmailId.setError("Please enter valid email id");
        } else if (patientAppointmentDate.getText().toString().trim().length() == 0 ){
            patientAppointmentDate.setError("Please select valid date");
        } else if (patientAppointmentTime.getText().toString().trim().length() == 0 ) {
            patientAppointmentTime.setError("Please select valid time");
        } else if (createdDateUTC.toString().trim().length() == 0 && notificationDate.toString().trim().length() == 0) {
            Toast.makeText(getApplicationContext(), "Show Alert for found null notification date", Toast.LENGTH_SHORT).show();
        } else {

            Log.d(TAG,"createdDateUTC: " + createdDateUTC);
            Log.d(TAG,"notification date: " + createdDateUTC);
            Toast.makeText(getApplicationContext(), "Success", Toast.LENGTH_SHORT).show();
            AddPatientAppointment addNotification = new AddPatientAppointment(patientName.getText().toString(),
                    patientMobileNo.getText().toString(),
                    createdDateUTC,
                    createdDateUTC);
            addNotification.execute();
        }
    }



    public String getCurrentDateInMilliSeconds() {
            // Date currentDate = new Date();
            // long millis = currentDate.getTime();
        // SimpleDateFormat currentDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        Date todayDate = new Date();
        long millis = todayDate.getTime();
        // String thisDate = currentDate.format(todayDate);
        return  "/Date(" + millis + ")/" ;
    }

    public class AddPatientAppointment extends AsyncTask {

        String patientName;
        String phoneNumber;
        String createdDateUtc;
        String notificationDate;
        public AddPatientAppointment(String patientName, String phoneNumber, String createdDateUtc, String notificationDate) {
            this.patientName = patientName;
            this.phoneNumber = phoneNumber;
            this.createdDateUtc = createdDateUtc;
            this.notificationDate = notificationDate;
        }
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
            String url = "http://drishtitechnologies.in/api/PatientNotifications";

            Map<String, String> jsonParams = new HashMap<String, String>();
            jsonParams.put("NotificationId", "0");
            jsonParams.put("PatientName", patientName);
            jsonParams.put("PhoneNumber", phoneNumber);
            jsonParams.put("CreatedDateUtc", createdDateUtc);
            jsonParams.put("NotificationDate", notificationDate);
            jsonParams.put("Status", "1");


            JsonObjectRequest myRequest = new JsonObjectRequest(
                    Request.Method.POST,
                    url,
                    new JSONObject(jsonParams),

                    new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            Log.d(TAG, "Response is:" + response);
                            finish();
                        }
                    },
                    new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            Log.d(TAG, "*********************ERROR****************:" + error);
                        }
                    }) {

                @Override
                public Map<String, String> getHeaders() throws AuthFailureError {
                    HashMap<String, String> headers = new HashMap<String, String>();
                    headers.put("Content-Type", "application/json; charset=utf-8");
                    headers.put("Accept", "application/json");
                    return headers;
                }
            };

            myRequest.setRetryPolicy(new DefaultRetryPolicy(3000,
                    DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                    DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
            return queue.add(myRequest);
        }



            /*
            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    Toast.makeText(getApplicationContext(), response, Toast.LENGTH_LONG).show();
                    Log.d(TAG, "Response is:" + response);
                    // finish();
                    // Intent appointmentIntent = new Intent(getApplicationContext(), MainActivity.class);
                    // startActivity(appointmentIntent);
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    Toast.makeText(getApplicationContext(), error.getMessage(), Toast.LENGTH_LONG).show();
                }
            }){

                @Override
                public Map<String, String> getHeaders()  { //throws AuthFailureError
                    HashMap<String, String> headers = new HashMap<String, String>();
                    headers.put("Content-Type", "application/json");
                    headers.put("Accept", "application/json");
                    return headers;
                }

                @Override
                protected Map<String, String> getParams() {
                    Map<String, String> params = new HashMap<String, String>();
                    params.put("NotificationId", "0");
                    params.put("PatientName", "Shri");
                    params.put("PhoneNumber", "8605513440");
                    params.put("CreatedDateUtc", "/Date(1487317859835)/");
                    params.put("NotificationDate", "/Date(1487272800077)/");
                    params.put("Status", "1");
                    JSONObject obj = new JSONObject(params);
                    Log.d(TAG, obj.toString());
                    return obj.toString();
                }
            };

            queue.add(stringRequest);
            return null;
            */
        // }

    }


   /* public class NotificationClass {
                int NotificationId;
                String PatientName;
                int PhoneNumber;
                String CreatedDateUtc;
                String NotificationDate;
                int Status;
    }*/


}
/*


            EditText Validation

            TextInputLayout nameLayout = (TextInputLayout) findViewById(R.id.layoutName);
            nameLayout.setError("Please enter valid name");

            Date curDate = new Date();
            long curMillis = curDate.getTime();
            String curTime = sdf.format(curDate);

            Calendar calendar = Calendar.getInstance();
            calendar.set(datePicker.getYear(), datePicker.getMonth(), datePicker.getDayOfMonth(),
                    timePicker.getHour(), timePicker.getMinute(), 0);
            long startTime = calendar.getTimeInMillis();

            Toast.makeText(getApplicationContext(), "" + startTime, Toast.LENGTH_LONG).show();
 */