#!/bin/bash
#!/bin/bash

AWSACCOUNTIDNAMES=( )
AWSACCOUNTIDS=( )

AWSACCOUNTIDNAMES[0]="Polylegio"
AWSACCOUNTIDS[0]="00000000000"

AWSACCOUNTIDNAMES[1]="Telstra-IDN-Dev"
AWSACCOUNTIDS[1]="661974762419"

AWSACCOUNTIDNAMES[2]="Telstra-IDN-Prod"
AWSACCOUNTIDS[2]="878112776113"

while [[ 1 == 1 ]]
do
    echo "Select license type:"
    echo "1) AWS Account"
    echo "2) Certificate signed"
    echo "3) No license"

    read selection
    echo "Selection is ${selection}"
    MAKEARGS=""
    if [ $selection -eq 1 ]; then
        while [[ 1 == 1 ]]
        do
            for IDidx in ${!AWSACCOUNTIDS[@]}
                        do
#                echo "${IDidx} ) "
                echo "${IDidx} ) ${AWSACCOUNTIDNAMES[$IDidx]}"
            done
            read selection;
            if [ ${selection} -gt $IDidx ]; then
                echo "ERROR: Not selectable."
                echo ""
            else
                break
            fi
        done
       MAKEARGS="LICENSEOPTIONS=-D BUILD_RELEASE -D WITH_LICENSE_AWS_ACCOUNTID -D AWS_CLIENT_ACCOUNTID=\\\"${AWSA
CCOUNTIDS[$selection]}\\\""
        break;
    elif [ $selection -eq 2 ]; then
        MAKEARGS="LICENSEOPTIONS=-D BUILD_RELEASE -DWITH_LICENSE"
        break;
    elif [ $selection -eq 3 ]; then
        MAKEARGS="LICENSEOPTIONS=-D BUILD_RELEASE"
        break;
    else
        echo "Invalid choice"
    fi
done

echo ${MAKEARGS}

#execute build, we set the DEBUG variable to empty string so we dont by accident export the source code
cd paftransfer
make clean
make  DEBUG="" "${MAKEARGS}"
cd ..
