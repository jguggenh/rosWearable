#!/usr/bin/env python
import rospy
import time
import random
from std_msgs.msg import Int16
from sensor_msgs.msg import Joy

def fgCallback(data):
	# publish emg
	fgPos = data
	fgPub.publish(fgPos)
	rospy.spin()

def leadArmRandomMove():
	# move lead arm to automated position between 20-160, where 90 is perpendicular to the ground
	angleSpread = 70
	lBound = 90 - angleSpread
	uBound = 90 + angleSpread
	leadPos = int(random.uniform(lBound,uBound))
	leadArmPub.publish(leadPos)
	rospy.spin()

def start():
	# initialize node
	rospy.init_node('fgDemo2Arduino', anonymous = True)

	# initialize follow arm publisher
	global fgPub
	fgPub = rospy.Publisher('fgPub', Int16, queue_size = 10)

	# initialize lead arm publisher
	global leadArmPub
	leadArmPub = rospy.Publisher('leadArmPub', Int16, queue_size = 10)

	# initialize force glove subscriber
	global fgSubscriber
	fgSubscriber = rospy.Subscriber("servoPosFG", Int16, fgCallback)

	# put both arms to 90 to ensure calibration
	fgPub.publish(90)
	leadArmPub.publish(90)

	# call runTrial
	# runTrial()	

	# rospy.spin()
	rospy.spin()

def runTrial():
	# stuff for timing trials
	lengthInterval = 10
	lengthTrial = 2*lengthInterval
	baseTime = time.time()
	trialTime = 0
	moveLeadArm = 0

	# let ros work
	rospy.spin()

	# start trial
	while trialTime < lengthTrial:
		# every 10 seconds move lead arm
		if trialTime%10 < 1 and moveLeadArm == 1:
			#leadArmRandomMove()
			leadArmPub.publish(-9999)
			moveLeadArm = 0

		leadArmPub.publish(1)

		# update timer
		trialTime = time.time() - baseTime

		# update flag
		if trialTime%10 > 1 and trialTime%10 < 2 and moveLeadArm == 0:
			moveLeadArm = 1

		# rospy.spin()
		rospy.spin()

if __name__ == '__main__':
    try:
        start()
    except rospy.ROSInterruptException:
        pass
