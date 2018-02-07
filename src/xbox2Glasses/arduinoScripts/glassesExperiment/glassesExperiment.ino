#include <ros.h>
#include <ArduinoHardware.h>
#include <std_msgs/Int16.h>

// ros stuff
ros::NodeHandle ard2Glasses;

void glassesCallback(const std_msgs::Int16& glassesData)
{ 
  int glassesOn = glassesData.data;
  if (glassesOn == 1)
  {
    digitalWrite(8, HIGH);   
  }
  else
  {
    digitalWrite(8, LOW);
  }
}

ros::Subscriber<std_msgs::Int16> glassesSub("xbox2GlassesPub", &glassesCallback);

void setup() 
{
  //initialize ros
  ard2Glasses.initNode();
  ard2Glasses.subscribe(glassesSub);

  // initialize pin mode
  pinMode(8,OUTPUT);
}

void loop() 
{
  ard2Glasses.spinOnce();
}
