#!/usr/bin/env python
import rospy
import time
import random
from std_msgs.msg import Int16
from sensor_msgs.msg import Joy

def xboxCallback(data):
	# check if user ended trial by pressing "A"
	if data.buttons[0] == 1:
		# unsubscribe from joy, trial has ended
		joySubscriber.unregister()
		
		# start new one
		runTrial(0)

	# publish y value of left joystick
	joyPositions = int((data.axes[1]+1)*70+20)
	followArmPub.publish(joyPositions)

def buttonCallback(data):
	# check if user ended trial by pressing "A"
	if data.buttons[0] == 1:
		# unsubscribe from joy, trial has ended
		buttonSubscriber.unregister()
		emgSubscriber.unregister()
		
		# start new one
		runTrial(0)

def emgCallback(data):
	# publish emg
	emgPos = data
	followArmPub.publish(emgPos)


def start():
	# initialize node
	rospy.init_node('controlSignal2Arduino', anonymous = True)

	# initialize follow arm publisher
	global followArmPub
	followArmPub = rospy.Publisher('followArmPub', Int16, queue_size = 10)

	# initialize lead arm publisher
	global leadArmPub
	leadArmPub = rospy.Publisher('leadArmPub', Int16, queue_size = 10)

	# put both arms to 90 to ensure calibration
	followArmPub.publish(90)
	leadArmPub.publish(90)
	time.sleep(3)

	# which control signal are we using (0 = xbox, 1 = emg)? 
	controlSignal = 0

	# call runTrial
	runTrial(controlSignal)	

	# rospy.spin()
	rospy.spin()

def runTrial(controlSignal):
	# first call leadArmRandomMove
	leadPos = leadArmRandomMove()
	time.sleep(3)
	
	# now let user controller arm

	if controlSignal == 0: # using xbox
		global joySubscriber
		joySubscriber = rospy.Subscriber("joy", Joy, xboxCallback)
	if controlSignal == 1: # using emg
		global emgSubscriber
		global buttonSubscriber
		emgSubscriber = rospy.Subscriber("servoPosEMG", Int16, emgCallback)
		# also need joy just for A button...ugh
		buttonSubscriber = rospy.Subscriber("joy", Joy, buttonCallback)
	
	# rospy.spin()
	rospy.spin()	

def leadArmRandomMove():
	# move lead arm to automated position between 20-160, where 90 is perpendicular to the ground
	angleSpread = 70
	lBound = 90 - angleSpread
	uBound = 90 + angleSpread
	leadPos = int(random.uniform(lBound,uBound))
	leadArmPub.publish(leadPos)
	return leadPos

if __name__ == '__main__':
    try:
        start()
    except rospy.ROSInterruptException:
        pass
