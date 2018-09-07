package com.example.customerquestion;

import com.example.customerquestion.LoginInput;
import com.example.customerquestion.LoginResult;
import com.example.customerquestion.IOperations;
import com.example.customerquestion.OperationsImpl;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends Activity {

	Button login;
	EditText userName, password;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		login = (Button) findViewById(R.id.login);
		userName = (EditText) findViewById(R.id.userName);
		password = (EditText) findViewById(R.id.password);

		login.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				CalcAsyncTask task = new CalcAsyncTask();
				LoginInput input = new LoginInput();

				input.userName = userName.getText().toString();
				input.password = password.getText().toString();

				task.input = input;
				task.execute("Login");
			}
		});
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main2, menu);
		return true;
	}

	private class CalcAsyncTask extends AsyncTask<String, Void, String> {
		public LoginInput input;
		public LoginResult calcResult = new LoginResult();

		@Override
		protected String doInBackground(String... urls) {
			IOperations i = new OperationsImpl();
			if (urls[0] == "Login") {
				calcResult = i.Login(input);
			}
			return "";
		}

		/* Çıktıların gözükeceği yeri belirtmektedir. */
		@Override
		protected void onPostExecute(String result) {
			Toast.makeText(getApplicationContext(),
					"ISLEM SONUCU : " + calcResult.sessionKey,
					Toast.LENGTH_LONG).show();
		}
	}
}