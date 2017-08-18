#include <ros.h>
#include <ArduinoHardware.h>
#include <std_msgs/Int64.h> 
#include <readEMG/EMG.h>

#include <Wire.h>
#include <Adafruit_ADS1015.h>

// adc stuff
Adafruit_ADS1115 ads;
float multiplier; // conversion to mV

// ros stuff
ros::NodeHandle emgADC;
std_msgs::Int64 emgSignal;
ros::Publisher emgPub("emgPub", &emgSignal);

// sample time check
unsigned long time;
  
void setup(void)
{
//  // initiate ros 
//  emgADC.initNode();
//  emgADC.advertise(emgPub);
  
  // initiate adc
  ads.begin();
  multiplier = ads.voltsPerBit()*1000.0F;    
  
  // set sample rate to 860
  ads.setSPS(ADS1115_DR_860SPS);  
  
  Serial.begin(115200);
}

void loop(void)
{
  // read emg signal
//  emgSignal.data = ads.readADC_Differential_0_1();
  double data = ads.readADC_Differential_0_1();
  Serial.println(data);
  
  float data1 = analogRead(A0);
  Serial.print("blah ");
  Serial.println(data1);
  
    
//  // publish that value
//  emgPub.publish(&emgSignal);
//  
//  // ros stuff
//  emgADC.spinOnce();

}
