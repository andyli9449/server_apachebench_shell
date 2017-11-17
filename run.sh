echo "you maybe use this sh like:"$0" serverIP userParam"
#a=(1 100 100 1000 1000)
#b=(1 50 100 500 1000)
a=(20000)
b=(10)
runTime=$(date +%Y%m%d%H%M%S)

if [ -z "$1"]
then
	serverip="http://127.0.0.1"
else
	serverip=$1
fi

if [ -z "$2"]
then
	param=""
else
	param=$2
fi

filename=${runTime}"-test.log"
touch filename

#api=('/devices/camera?'${param} '/V2/files/storageinfo?sdate=2017/11/01&edate=2017/11/30&'${param} '/V2/files/list?date=2017/11/14&'${param} '/users/account')
api=('/users/account')
echo "********webserver test info*************"
echo "testTime :"$(date) 
echo "LogName  :"${filename}
echo "serverIP :"${serverip}
echo "userparam:"${param}
echo "********webserver test info*************" 
#echo ${filename}

for j in {0..0}
do
	echo "API test:"${serverip}${api[j]}
	for i in {0..4}
	do
		ab -r -k -n ${a[i]} -c ${b[i]} -C ${param} ${serverip}${api[j]} | grep -e"Document Path:" -e "Complete requests:" -e "Concurrency Level:" -e"Failed requests:" -e"Time taken for tests:" -e "Requests per second:" -e "Time per request" -e"Total transferred: " >> ${filename}
	done
done
sed -i 's/^.\{24\}//g' ${filename}
export LD_LIBRARY_PATH=
./change ${filename} ${runTime}"report.xls"
rm ${filename} 