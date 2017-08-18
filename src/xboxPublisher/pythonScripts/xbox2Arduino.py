#!/usr/bin/env python
import rospy
import time
import random
from std_msgs.msg import Float64
from sensor_msgs.msg import Joy

def callback(data):
	# check if user ended trial by pressing "A"
	if data.buttons[0] == 1:
		# unsubscribe from joy, trial has ended
		joySubscriber.unregister()
		
		# start new one
		runTrial()

	# publish y value of left joystick
	joyPositions = int((data.axes[1]+1)*70+20)
	xboxPub.publish(joyPositions)

def start():
	# initialize node
	rospy.init_node('xbox2Arduino', anonymous = True)

	# initialize xbox publisher
	global xboxPub
	xboxPub = rospy.Publisher('xboxPub', Float64, queue_size = 10)

	# initialize lead arm publisher
	global leadArmPub
	leadArmPub = rospy.Publisher('leadArmPub', Float64, queue_size = 10)

	# put both arms to 90 to ensure calibration
	xboxPub.publish(90)
	leadArmPub.publish(90)
	time.sleep(3)

	# call runTrial
	runTrial()	

	# rospy.spin()
	rospy.spin()

def runTrial():
	# first call leadArmRandomMove
	leadPos = leadArmRandomMove()
	time.sleep(3)

	# now let user controller arm...first subscribe to joy
	global joySubscriber
	joySubscriber = rospy.Subscriber("joy", Joy, callback)
	
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
