package io.agora.api.example;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import io.agora.api.example.common.model.GlobalSettings;
import io.agora.api.example.databinding.ActivitySettingLayoutBinding;
import io.agora.rtc2.RtcEngine;

/**
 * @author cjw
 */
public class SettingActivity extends AppCompatActivity{
    private static final String TAG = SettingActivity.class.getSimpleName();

    private ActivitySettingLayoutBinding mBinding;
    private MenuItem saveMenu;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mBinding = ActivitySettingLayoutBinding.inflate(LayoutInflater.from(this));
        setContentView(mBinding.getRoot());
        mBinding.sdkVersion.setText(String.format(getString(R.string.sdkversion1), RtcEngine.getSdkVersion()));
        fetchGlobalSettings();
    }

    private void fetchGlobalSettings(){
        GlobalSettings globalSettings = ((MainApplication)getApplication()).getGlobalSettings();

        String[] mItems = getResources().getStringArray(R.array.areaCode);
        String selectedItem = globalSettings.getAreaCodeStr();
        int i = 0;
        if(selectedItem!=null){
            for(String item : mItems){
                if(selectedItem.equals(item)){
                    break;
                }
                i++;
            }
        }
        mBinding.areaSpinner.setSelection(i);


        mBinding.privateCloudLayout.etIpAddress.setText(globalSettings.privateCloudIp);
        mBinding.privateCloudLayout.swLogReport.setChecked(globalSettings.privateCloudLogReportEnable);
        mBinding.privateCloudLayout.etLogServerDomain.setText(globalSettings.privateCloudLogServerDomain);
        mBinding.privateCloudLayout.etLogServerPort.setText(globalSettings.privateCloudLogServerPort + "");
        mBinding.privateCloudLayout.etLogServerPath.setText(globalSettings.privateCloudLogServerPath);
        mBinding.privateCloudLayout.swUseHttps.setChecked(globalSettings.privateCloudUseHttps);
    }

    @Override
    public boolean onCreateOptionsMenu(@NonNull Menu menu) {
        saveMenu = menu.add(R.string.save);
        saveMenu.setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == saveMenu.getItemId()) {
            GlobalSettings globalSettings = ((MainApplication)getApplication()).getGlobalSettings();
            globalSettings.privateCloudIp = mBinding.privateCloudLayout.etIpAddress.getText().toString();
            globalSettings.privateCloudLogReportEnable = mBinding.privateCloudLayout.swLogReport.isChecked();
            globalSettings.privateCloudLogServerDomain = mBinding.privateCloudLayout.etLogServerDomain.getText().toString();
            globalSettings.privateCloudLogServerPort = Integer.parseInt(mBinding.privateCloudLayout.etLogServerPort.getText().toString());
            globalSettings.privateCloudLogServerPath = mBinding.privateCloudLayout.etLogServerPath.getText().toString();
            globalSettings.privateCloudUseHttps = mBinding.privateCloudLayout.swUseHttps.isChecked();

            globalSettings.setAreaCodeStr(getResources().getStringArray(R.array.areaCode)[mBinding.areaSpinner.getSelectedItemPosition()]);
            onBackPressed();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

}
