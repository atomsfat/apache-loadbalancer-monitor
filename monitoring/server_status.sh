#!/bin/bash
print_status() 
{
	
	web=$1
	curl -Is $web | gawk '/HTTP*/ {print $2}'  
}

print_status $1


