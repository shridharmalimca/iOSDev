package com.example.shridharmali.appointment;

import android.app.Dialog;
import android.app.TimePickerDialog;
import android.icu.util.Calendar;
import android.icu.util.TimeZone;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.widget.TimePicker;

import java.util.Locale;

/**
 * Created by shridharmali on 2/15/17.
 */

public class TimePickerFragment extends DialogFragment implements TimePickerDialog.OnTimeSetListener {

    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        super.onCreateDialog(savedInstanceState);

        final Calendar c = Calendar.getInstance();
        int hours = c.get(Calendar.HOUR);
        int min = c.get(Calendar.MINUTE);

        return new TimePickerDialog(getActivity(), this, hours, min, false);
    }

    @Override
    public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
        // view.setHour(java.util.Calendar.HOUR);
        // view.setMinute(java.util.Calendar.MINUTE);
        AddAppointment callingActivity = (AddAppointment) getActivity();
        String AM_PM ;
        if(hourOfDay < 12) {
            AM_PM = "AM";
        } else {
            AM_PM = "PM";
        }
        String time = new String();
        time = hourOfDay + ":" + minute + " " + AM_PM;
        callingActivity.getSelectedTime(time, view);
        dismiss();
    }
}
