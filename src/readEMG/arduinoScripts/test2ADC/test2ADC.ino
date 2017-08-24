#include <ros.h>
#include <ArduinoHardware.h>
#include <std_msgs/Int16.h> 
#include <std_msgs/Int16MultiArray.h>  

#include <Wire.h>
#include <Adafruit_ADS1015.h>

// adc stuff
Adafruit_ADS1115 ads1(0x48);
Adafruit_ADS1115 ads2(0x49);
float multiplier; // conversion to mV

// ros stuff
ros::NodeHandle emgADC;
std_msgs::Int16MultiArray emgSignal;
ros::Publisher emgPub("emgPub", &emgSignal);

// sample time check
unsigned long time;
  
void setup(void)
{
  // initiate ros 
  emgADC.initNode();
  
  // define message
  emgSignal.layout.dim[0].size = 2;
  emgSignal.layout.dim[0].stride = 1*2;
  emgSignal.data = (int *)malloc(sizeof(int)*2);
  emgSignal.data_length = 2;
  
  //advertise signal
  emgADC.advertise(emgPub);
  
  // initiate adc
  ads1.begin();
//  ads2.begin();   
  multiplier = ads1.voltsPerBit()*1000.0F;    

  // set sample rate to 860
  ads1.setSPS(ADS1115_DR_860SPS); 
//  ads2.setSPS(ADS1115_DR_860SPS);  
}

void loop(void)
{
  // read emg signal
  emgSignal.data[0] = ads1.readADC_Differential_0_1();
  emgSignal.data[1] = emgSignal.data[0];
//  emgSignal.data[1] = ads2.readADC_Differential_0_1();

    
  // publish that value
  emgPub.publish(&emgSignal);
  
  // ros stuff
  emgADC.spinOnce();

}
