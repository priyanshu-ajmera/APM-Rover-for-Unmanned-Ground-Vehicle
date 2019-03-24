#include <Wire.h>
#include <ros.h>
#include <std_msgs/Int16.h>
#include <std_msgs/UInt16.h>
#include "mot_a.h"
#include "mot_b.h"
#include "enc_r.h"
#include "enc_l.h"
unsigned long time_i = 0, time_f = 0;
std_msgs::UInt16 msg_time;
ros::Publisher t_value("t_value", &msg_time);
#include "ros_stuff.h"

void setup() 
{
	//Serial.begin(57600);

  pinMode(13,OUTPUT);

	mot_a_setup();
	mot_b_setup();

	enc_r_setup();
	enc_l_setup();

	nh.initNode();
	
	nh.subscribe(sub_l);
  nh.subscribe(sub_r);

  nh.subscribe(sub_reset_time_enco);
  
	nh.advertise(enco_R);
	nh.advertise(enco_L);

  nh.advertise(t_value);
}

void loop()
{
  time_f = millis();
  msg_time.data = time_f-time_i;
  t_value.publish(&msg_time);
  
	msg_R.data = enco_R_pos;
	msg_L.data = enco_L_pos;
	
	enco_R.publish(&msg_R);
	enco_L.publish(&msg_L);
	
	nh.spinOnce();

	delay(10);

//  Serial.print(millis());
//  Serial.print("\t");
//  Serial.print(enco_R_pos);
//  Serial.print("\t");
//  Serial.println(enco_L_pos);
}
