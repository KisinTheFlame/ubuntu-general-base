SH_DIR="/etc/kinit.d/sh"
cat /etc/kinit.d/hosts >> /etc/hosts
for file in `ls $SH_DIR`
do
    sh $SH_DIR/$file
done