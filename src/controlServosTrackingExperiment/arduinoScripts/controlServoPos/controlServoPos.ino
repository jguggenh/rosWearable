#include <ros.h>
#include <ArduinoHardware.h>
#include <std_msgs/Int16.h>
#include <std_msgs/Float64.h>
#include <sensor_msgs/Joy.h>
#include <VarSpeedServo.h>

// define pins/variables for servo
VarSpeedServo servo1;
#define servo1Pin 4
int servo1UpperBound = 160;
int servo1LowerBound = 20;
int servo1Speed = 20;
int servo1Offset = -27;

VarSpeedServo servo2;
#define servo2Pin 2
int servo2UpperBound = servo1UpperBound;
int servo2LowerBound = servo1LowerBound;
int servo2Speed = 20;
int servo2Offset = -17;

//ros stuff
ros::NodeHandle ard2Servos;

void followCallback(const sensor_msgs::Joy& joyData)
{
 int servo1Pos = int((joyData.axes[1]+1)*70+20);
 servo1.slowmove(180-servo1Pos+servo1Offset, servo1Speed);
}

void leadCallback(const std_msgs::Int16& leadData)
{
 int servo2Pos = leadData.data;
 servo2.slowmove(servo2Pos+servo2Offset, servo2Speed);
}
  
// create subscribers to both followArmPub and leadArmPub  
ros::Subscriber<sensor_msgs::Joy> followSub("joy", &followCallback);
ros::Subscriber<std_msgs::Int16> leadSub("leadArmPub", &leadCallback);

// test pub
std_msgs::Float64 timing;
ros::Publisher testPub("testPub",&timing);
float prevTime = 0;
float currTime = 0;

void setup()
{
  //initiate ros
  ard2Servos.initNode();
  ard2Servos.subscribe(followSub);
  ard2Servos.subscribe(leadSub);

//  //test pub for timing
//  ard2Servos.advertise(testPub);
  
  // initiate servo1
  int blah1 = servo1.read();
  servo1.attach(servo1Pin,0,255);
  servo1.write(blah1);
  servo1.slowmove(0+servo1Offset, servo1Speed);

  // initiate servo2
  int blah2 = servo2.read();
  servo2.attach(servo2Pin,0,255);
  servo2.write(blah2);
  servo2.slowmove(90+servo2Offset, servo2Speed);
  
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
  ard2Servos.spinOnce();
  delay(1);
}
