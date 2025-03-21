AWS_REGION="ap-south-1"
Total=0
Instid=$(AWS_ACCESS_KEY_ID=$1 AWS_SECRET_ACCESS_KEY=$2 aws ec2 describe-instances --region ap-south-1 | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId')
echo $Instid
if [ $Instid -ge 1 ];then
                ImageStatus="Success";
                ImageFeedback="Javaservice container image created successfully";
                ImageScore=100;
		Total=$(echo "$Total + $ImageScore" | bc)
        else
		ImageStatus="Failure";
                ImageFeedback="Javaservice container image not created";
                ImageScore=0;
                Total=$(echo "$Total + $ImageScore" | bc)
fi
echo $Total
#Result
        Result='@responsestart@ \n
        {\n
                "Exercise": "Ex:1 Java service",\n
                "TestCases": [{ \n
                "Name": "Javaservice Image", \n
                "Status": "'$ImageStatus'", \n
                "Skill": "Beginner", \n
                "Score": "'$ImageScore'% ",\n
                "Feedback": "'$ImageFeedback' ",\n
                "Observation": "",\n
                "ConsoleOutput": ""\n
                }],\n
                "TotalScore":"'$Total'%"\n
        }\n
                        @responseend@'
                echo -e $Result
