#!/usr/bin/env python
import rospy
import numpy as np
from scipy import interpolate
import math
import random
from std_msgs.msg import Int16

def start():
	# initialize node
	rospy.init_node('posTraj', anonymous = True)

	# initialize lead arm publisher
	global leadArmPub
	leadArmPub = rospy.Publisher('leadArmPub', Int16, queue_size = 10)

	# put lead arm to neutral position
	leadArmPub.publish(90)
	rospy.sleep(3.)

	# generate trajectory
	trajPubRate = 500.0; # Hz
	trajVec = genTraj(trajPubRate)	

	# begin sending traj
	sendTraj(trajPubRate, trajVec)

	# rospy.spin()
	rospy.spin()

def genTraj(trajPubRate):
	maxVel = 50 # degrees per second
	minAngle = 20
	maxAngle = 160
	
	trialLength = 20 # seconds

	# first get time indicies	
	# not sure i need this...timeVec = np.arange(0.0,trialLength,1/trajPubRate)

	# random seed
	random.seed()

	# now generate reference points for trajectory
	trajVecSparse = np.zeros(int(trialLength))
	trajVecSparse[0] = 90
	for i in range(1,trialLength): # go from 1 because at 0 its set at 90
		trajVecSparse[i] = random.random()*(maxAngle - minAngle) + minAngle
		
		# ensure it doesn't exceed max velocity
		if (abs(trajVecSparse[i] - trajVecSparse[i-1]) > maxVel):
			if trajVecSparse[i] > trajVecSparse[i-1]:
				trajVecSparse[i] = trajVecSparse[i-1] + maxVel
			if trajVecSparse[i] < trajVecSparse[i-1]:
				trajVecSparse[i] = trajVecSparse[i-1] - maxVel 
	
	# now interpolate at trajPubRate
	interpFun = interpolate.interp1d(np.arange(0,len(trajVecSparse),1),trajVecSparse,kind="cubic")
	timeVec = np.arange(0.0,trialLength-1,1/trajPubRate)	
	trajVec = interpFun(timeVec)
	return trajVec

def sendTraj(trajPubRate, trajVec):
	# ask lead arm to follow randomized trajectory
	loopNum = 0
	rate = rospy.Rate(trajPubRate) # hertz
	while (not rospy.is_shutdown()) and (loopNum < (len(trajVec)-1)):
		# do stuff
		loopNum = loopNum + 1
		leadArmPub.publish(trajVec[loopNum])

		# sleep to maintain loop rate
		rate.sleep()

if __name__ == '__main__':
    try:
        start()
    except rospy.ROSInterruptException:
        pass
