#!/bin/bash
#Programe:
#This program is a game to guess the number which is equal to the RANDOM given by the computer
clear
echo "*************************************"
echo "The name of the game is Guess Number"
echo "The program revised by PoppyBu"
echo "Version 1.0"
echo "*************************************"
#This is the initial_password part
initial_password()
{
		Password=`echo $(($RANDOM%10000))`          #产生0-10000的随机数
		echo $Password | grep '^[0-9]\{4\}$' > /dev/null 2>&1
		#echo $Password
		if [ $? != 0 ]
		then
		initial_password
		else
		input_number
		fi
}
#This is the input_number part
input_number()
{
		echo -n "Please input the number you guess:(1000-9999) "
		read Inputnum
		echo $Inputnum | grep '^[0-9]\{4\}$' > /dev/null 2>&1
		if [ $? != 0 ]
		then
		echo "Retry, and promise your number is between 1000-9999!!!!!"
		input_number
		else
		comp_number
		fi	
}
#This is the main of the program: comp_number
comp_number()
{
		X=$Inputnum
		Y=$Password
		while [ $Inputnum != $Password ]
		do
					A=0
					B=0
					judge_a                            #输出?A?B的模式，其中A前面的数字代表处于正确位置并且数字也正确的个数，B前面的数字代表处于错误位置但是数字正确的个数
					judge_b
					Loop=$(($Loop+1))
					echo "*************************************************"
					echo "*                              "$A"A"$B"B                          *"
					echo "There are $A numbers in correct position!"
					echo "There are $B numbers in incorrect position"
					if [ $Inputnum -gt $Password ]
					then
								echo "Need a SMALL number!!!"
					elif [ $Inputnum -lt $Password ]
					then
								echo "Need a BIG number!!!"
					fi
		echo "***************************************************"
		input_number
		done
}
#This is the judge_a part
judge_a()
{
		for i in `seq 4`
		do
			VAR_input=`expr substr "$X" $i 1`
			for j in `seq 4`
			do
				VAR_pass=`expr substr "$Y" $j 1`
				if [[ $VAR_input = $VAR_pass && $VAR_input != "" && $VAR_pass != "" && $i = $j ]]     ######错误出在$i = $j，需要特别注意，当使用[[]]时千万不要吝啬空格的使用！！！！！
				then
				A=`expr $A + 1`
				X=`expr substr $X 1 "$[$i-1]"``expr substr $X "$[$i+1]" 4`
				Y=`expr substr $Y 1 "$[$i-1]"``expr substr $Y "$[$i+1]" 4`
				#A=$(($A + 1))
				judge_a   #记得有一个循环的过程！！！！！！！！！！！！
				fi
			done
		done
}
#This is the judge_b part
judge_b()
{
		for i in `seq 4`
		do
		VAR_input=`expr substr "$X" $i 1`
			for j in `seq 4`
			do
				VAR_pass=`expr substr "$Y" $j 1`
				if [[ $VAR_input = $VAR_pass && $VAR_input != "" && $VAR_pass != "" ]]
				then
				X=`expr substr "$X" 1 "$[$i-1]"``expr substr "$X" "$[$i+1]" 4`
				Y=`expr substr "$Y" 1 "$[$j-1]"``expr substr "$Y" "$[$j+1]" 4`
				#B=$(($B+1))
				B=`expr $B + 1`
				judge_b                                #记得有一个循环的过程！！！！！！！！！
				fi
			done
		done
}
#This is the begin of the program
Loop=1
initial_password
echo "***************************************************"
echo "***************************************************"
echo "Congratulate!!! You have tried $Loop times and sueecssed!!!"
echo "The correct password is $Password"
echo "***************************************************"
echo "***************************************************"
