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
unsigned long timeDisplay;

int reads = 0;

void setup(void)
{
  //  // initiate ros 
  //  emgADC.initNode();
  //  
  //  emgSignal.layout.dim[0].size = 2;
  //  emgSignal.layout.dim[0].stride = 1*2;
  //  //emgSignal.layout.data_offset = 0;
  //  emgSignal.data = (int *)malloc(sizeof(int)*2);
  //  emgSignal.data_length = 2;
  //  
  //  emgADC.advertise(emgPub);

  // initiate adc
  ads1.begin();
  multiplier = ads1.voltsPerBit()*1000.0F;    

  ads2.begin();
  multiplier = ads2.voltsPerBit()*1000.0F;  

  // set sample rate to 860
  ads1.setSPS(ADS1115_DR_860SPS); 
  ads2.setSPS(ADS1115_DR_860SPS);   

  Serial.begin(115200);
}

void loop(void)
{
  // read emg signal
  int emg1 = ads1.readADC_Differential_0_1();
  int emg2 = ads2.readADC_Differential_0_1();

  reads = reads + 1;

  time = millis();

//  if (time > 1000*timeDisplay)
//  {
    timeDisplay = timeDisplay + 1;
//    Serial.print(emg1);
//    Serial.print(", ");
    Serial.println(emg2);
//    Serial.print(", ");
//    Serial.println(reads);
//    reads = 0;
//  } 
  //  if (time > timeDisplay)
  //  {
  //    Serial.print(emg1);
  //    Serial.print(", ");
  //    Serial.print(emg2);
  //    Serial.print(", ");
  //    Serial.println(time);
  ////    
  //    timeDisplay = timeDisplay + 1000;
  //  }


  //  // publish that value
  //  emgPub.publish(&emgSignal);
  //  
  //  // ros stuff
  //  emgADC.spinOnce();

}

