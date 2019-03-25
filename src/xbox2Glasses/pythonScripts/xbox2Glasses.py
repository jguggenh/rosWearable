#!/usr/bin/env python
import rospy
import time
from std_msgs.msg import Int16
from sensor_msgs.msg import Joy

def joyCallback(data):
	# publish A value of xbox controller.
	xbox2GlassesPub.publish(int((data.buttons[0])))

def start():
	# initialize node
	rospy.init_node('xbox2Glasses', anonymous = True)

	# initialize xbox2Glasses publisher
	global xbox2GlassesPub
	xbox2GlassesPub = rospy.Publisher('xbox2GlassesPub', Int16, queue_size = 10)

	# subscribe to joy
	global glassesJoySubscriber
	glassesJoySubscriber = rospy.Subscriber("joy", Joy, joyCallback)

	# rospy.spin()
	rospy.spin()


if __name__ == '__main__':
    try:
        start()
    except rospy.ROSInterruptException:
        pass
