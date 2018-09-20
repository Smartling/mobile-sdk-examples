package com.smartling.demo.acmeapp;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.smartling.demo.common.CommonActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onTap(View view) {
        Intent intent = new Intent(this, CommonActivity.class);
        startActivity(intent);
    }
}
