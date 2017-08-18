#!/usr/bin/env python
import rospy
import time
import os
from std_msgs.msg import Float64

def xboxCallback(data):
	currTime = str(time.time())
	currPos = str(data.data)
	stringToWrite = "User Position: " + currPos + ", " + currTime
	fId.write(stringToWrite)
	fId.write('\n')

def leadCallback(data):
	currTime = str(time.time())
	currPos = str(data.data)
	stringToWrite = "Lead Position: " + currPos + ", " + currTime
	fId.write(stringToWrite)
	fId.write('\n')
    
def start():
	# initiate node
	rospy.init_node('out2TextFile', anonymous=True)

	# subscribe to xbox pub
	rospy.Subscriber("xboxPub", Float64, xboxCallback)

	# subscribe to lead pub
	rospy.Subscriber("leadArmPub", Float64, leadCallback)

	# spin() simply keeps python from exiting until this node is stopped
	rospy.spin()

# start timer
startTime = time.time()

if __name__ == '__main__':
	currDir = os.getcwd
	fileLoc = "/home/jacob/Dropbox (MIT)/MIT/Asada/learningOnSRLs/rosWS/src/logExpOutput/Data/blah.txt"
	fId = open(fileLoc,'a');
	start()
