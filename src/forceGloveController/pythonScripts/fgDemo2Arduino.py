#!/usr/bin/env python
import rospy
import time
import random
import threading
from std_msgs.msg import Int16
from sensor_msgs.msg import Joy

def leadArmRandomMove():
	# move lead arm to automated position between 20-160, where 90 is perpendicular to the ground
	angleSpread = 70
	lBound = 90 - angleSpread
	uBound = 90 + angleSpread
	leadPos = int(random.uniform(lBound,uBound))
	leadArmPub.publish(leadPos)

def start():
	# initialize node
	rospy.init_node('fgDemo2Arduino', anonymous = True)

	# initialize lead arm publisher
	global leadArmPub
	leadArmPub = rospy.Publisher('leadArmPub', Int16, queue_size = 10)

	# put both arms to 90 to ensure calibration
	leadArmPub.publish(90)

	# call runTrial
	runTrial()	

	# rospy.spin()
	rospy.spin()

def runTrial():
	# stuff for timing trials
	lengthInterval = 10
	lengthTrial = 10*lengthInterval + 5 # add 5 so we get the last trial in
	baseTime = time.time()
	trialTime = 0
	moveLeadArm = 0

	# start trial
	while trialTime < lengthTrial:
		# every 10 seconds move lead arm
		if trialTime%lengthInterval < 1 and moveLeadArm == 1:
			leadArmRandomMove()
			moveLeadArm = 0

		# leadArmPub.publish(1)

		# update timer
		trialTime = time.time() - baseTime

		# update flag
		if trialTime%lengthInterval > 1 and trialTime%lengthInterval < 2 and moveLeadArm == 0:
			moveLeadArm = 1

	# rospy.spin()
	rospy.spin()

if __name__ == '__main__':
    try:
        start()
    except rospy.ROSInterruptException:
        pass
