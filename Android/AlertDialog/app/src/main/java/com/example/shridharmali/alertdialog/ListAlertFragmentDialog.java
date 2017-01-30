package com.example.shridharmali.alertdialog;

import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.DialogFragment;
import android.support.v7.app.AlertDialog;
import android.widget.Toast;

import java.lang.reflect.Array;
import java.util.List;

/**
 * Created by shridharmali on 1/30/17.
 */

public class ListAlertFragmentDialog extends DialogFragment {

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {

        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());

        builder.setTitle(R.string.pick_color)
                .setItems(R.array.colors_array, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        String[] arr = getResources().getStringArray(R.array.colors_array);
                        // The 'which' argument contains the index position
                        // of the selected item
                        Toast.makeText(getActivity(), arr[which].toString(), Toast.LENGTH_SHORT).show();
                    }
                });
        return builder.create();
    }
}
