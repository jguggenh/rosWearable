#include <ros.h>
#include <ArduinoHardware.h>
#include <std_msgs/Int16.h> 
#include <std_msgs/Int16MultiArray.h>  

#include <Wire.h>

// ros stuff
ros::NodeHandle forceGloveADC;
std_msgs::Int16MultiArray forceGloveSignal;
ros::Publisher forceGlovePub("forceGlovePub", &forceGloveSignal);

// sampe rate ros
//std_msgs::Int16 stSignal;
//ros::Publisher stPub("stPub", &stSignal);

// pins for fsr
int fsrPin2 = 0;     // the FSR and 10K pulldown are connected to a0
int fsrPinThumb = 1;     // the FSR and 10K pulldown are connected to a0
int fsrPinPointer = 6;     // the FSR and 10K pulldown are connected to a0
int fsrPinMiddle = 7;

int prevTime = 0;
int currTime = 0;

void setup(void) 
{
  // initiate ros 
  forceGloveADC.initNode();
  
  // define message
  forceGloveSignal.layout.dim[0].size = 2;
  forceGloveSignal.layout.dim[0].stride = 1*2;
  forceGloveSignal.data = (int *)malloc(sizeof(int)*2);
  forceGloveSignal.data_length = 2;
  
  //advertise signal
  forceGloveADC.advertise(forceGlovePub);

  //advertise sample rate pub
//  forceGloveA/C.advertise(stPub);
}
 
void loop(void) 
{
  // read force sensing resistor signal
  forceGloveSignal.data[0] = analogRead(fsrPinThumb); 
  forceGloveSignal.data[1] = analogRead(fsrPinPointer);  

  // publish that value
  forceGlovePub.publish(&forceGloveSignal);

  // ros stuff
  forceGloveADC.spinOnce();

  //check sample rate
//  currTime = millis();
//  stSignal.data = currTime-prevTime;
//  prevTime = currTime;
//  stPub.publish(&stSignal);
} 
