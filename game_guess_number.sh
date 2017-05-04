#!/bin/bash
clear
echo
echo "###################################################################"
echo "# this is a bash-shell game reviewed by PoppyBu#"
echo "# the game called Guess NUmber,and this version have repeated numbers #"
echo "#              version 1.0              #"
echo "###################################################################"
echo -e "\n\n"
#declare INPUT
#declare PASSWORD
#declare A
#declare B
#declare X
#declare Y
#declare LOOP             #进行数据输入的次数
#This funtion init the variable PASSWORD that user need to guess
init_password()
{
    PASSWORD=`echo $(($RANDOM%10000))`
    echo $PASSWORD | grep '^[0-9]\{4\}$' >/dev/null 2>&1   #‘ ^[0-9]\{4\}$ ’代表找出行首行尾之间只有4位数字的数值（1000到9999）
    if [ $? != 0 ]
    then
        init_password
    else
        input
    fi
}
#This funtion accept the input from user's keyboard
input()
{
    echo -n "please input a number between 1000-9999:"
    read INPUT
    echo $INPUT | grep '^[0-9]\{4\}$' >/dev/null 2>&1
    if [ $? != 0 ]
    then
        echo "retry a number between 1000-9999"
        input
    else
        judge
    fi
}
#This funtion is the main funtion
judge()
{
    X=$INPUT
    Y=$PASSWORD
    while [ $INPUT != $PASSWORD ]
    do
        A=0
        B=0
        judge_a
        judge_b
        LOOP=`expr $LOOP + 1`
        echo "****************************"
        echo "*                              "$A"A"$B"B                                *"
        echo "*there are $A numbers in correct position   *"
        echo "*there are $B numbers in incorrect position*"
        echo "****************************"
        if [ $INPUT -gt $PASSWORD ]
        then
        echo "Need a SMALL number!!!"
        elif [ $INPUT -lt $PASSWORD ]
        then
        echo "Need a BIG number!!!"
        fi
        input
    done
}
#This funtion count the variable A's value
judge_a()
{
        for i in `seq 4`
        do
            VAR_INPUT=`expr substr "$X" $i 1`
            for j in `seq 4`
            do
                VAR_PASSWORD=`expr substr "$Y" $j 1`
                if [[ $VAR_INPUT = $VAR_PASSWORD && $VAR_INPUT != "" && $VAR_PASSWORD != "" && $i = $j ]]   #&& $i=$j，代表比较时需要相同位置处的数字也要相同
                then
                    A=`expr $A + 1`
                    X=`expr substr $X 1 "$[$i-1]"``expr substr $X "$[$i+1]" 4` 
                    Y=`expr substr $Y 1 "$[$i-1]"``expr substr $Y "$[$i+1]" 4`    #排除了相同位置上，数字相同的情况
                    judge_a
                fi
            done
        done
}
#This funtion count the variable B's value
judge_b()
{
        for i in `seq 4`
        do
            VAR_INPUT=`expr substr "$X" $i 1`
            for j in `seq 4`
            do
                VAR_PASSWORD=`expr substr "$Y" $j 1`
                if [[ $VAR_INPUT = $VAR_PASSWORD && $VAR_INPUT != "" && $VAR_PASSWORD != "" ]]
                then
                    B=`expr $B + 1`
                    X=`expr substr "$X" 1 "$[$i-1]"``expr substr "$X" "$[$i+1]" 4`
                    Y=`expr substr "$Y" 1 "$[$j-1]"``expr substr "$Y" "$[$j+1]" 4`
                    judge_b
                fi
            done
        done
}
#This is the begin of script
LOOP=1
init_password
echo "#############################################"
echo "#congratulations! You have tried $LOOP times!  #"
echo "#    The password is $PASSWORD !       #"
echo "#############################################"
