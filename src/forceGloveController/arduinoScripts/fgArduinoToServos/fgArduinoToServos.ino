#include <ros.h>
#include <ArduinoHardware.h>
#include <std_msgs/Int16.h>
#include <std_msgs/Float64.h>
#include <VarSpeedServo.h>
#include "DualMC33926MotorShield.h"


// define pins/variables for servo
VarSpeedServo servo1;
#define servo1Pin 2
int servo1UpperBound = 160;
int servo1LowerBound = 20;
int servo1Speed = 20;
int servo1Offset = -27;

VarSpeedServo servo2;
#define servo2Pin 4
int servo2UpperBound = servo1UpperBound;
int servo2LowerBound = servo1LowerBound;
int servo2Speed = 20;
int servo2Offset = -17;

//ros stuff
ros::NodeHandle fgArduinoToServos;

void fgCallback(const std_msgs::Int16& fgData)
{
 int servo1Pos = fgData.data;
 //servo1.slowmove(180-servo1Pos+servo1Offset, servo1Speed);
 servo2.slowmove(servo1Pos+servo2Offset, servo2Speed);
}

void leadCallback(const std_msgs::Int16& leadData)
{
 int servo2Pos = leadData.data;
 servo2.slowmove(servo2Pos+servo2Offset, servo2Speed);
}
  
// create subscribers to both followArmPub and leadArmPub  
ros::Subscriber<std_msgs::Int16> fgSub("servoPosFG", &fgCallback);
ros::Subscriber<std_msgs::Int16> leadSub("leadArmPub", &leadCallback);

//// test pub
//std_msgs::Float64 timing;
//ros::Publisher testPub("testPub",&timing);
//float prevTime = 0;
//float currTime = 0;

void setup()
{
  //initiate ros
  fgArduinoToServos.initNode();
  fgArduinoToServos.subscribe(fgSub);
  fgArduinoToServos.subscribe(leadSub);

//  //test pub for timing
//  ard2Servos.advertise(testPub);
  
  // initiate servo1
  int blah1 = servo1.read();
  servo1.attach(servo1Pin,0,255);
  servo1.write(blah1);
  servo1.slowmove(10+servo1Offset, servo1Speed);

  // initiate servo2
  int blah2 = servo2.read();
  servo2.attach(servo2Pin,0,255);
  servo2.write(blah2);
  servo2.slowmove(10+servo2Offset, servo2Speed);

  delay(1000);
}

void loop()
{
//  // test pub
//  currTime = millis();
//  timing.data = currTime - prevTime;
//  prevTime = currTime;
//  testPub.publish(&timing);
  
  // ros
  fgArduinoToServos.spinOnce();
  delay(1);
}


