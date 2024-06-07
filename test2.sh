clear
tput cup 3 12; echo "Cong cu lam bai thi RHEL 9"
tput cup 4 12; echo "===================================="
tput cup 5 12; echo "***LUU Y : CAN PHAI SU DUNG USER ROOT ***"
tput cup 6 9; echo "1 - Kiem tra Hostname hien tai"
tput cup 7 9; echo "2 - Thay doi ten Hostname"
tput cup 8 9; echo "3 - Kiem tra thong tin Card mang hien tai"
tput cup 9 9; echo "4 - Doi IP tinh cua Card mang"
tput cup 10 9; echo "5 - Doi IP DHCP tu dong cua Card mang"
tput cup 11 9; echo "6 - Dang ky lai Subscription"
tput cup 12 9; echo "7 - Truyen tap tin bang giao thuc SCP"
tput cup 13 9; echo "8 - Huy dang ky Subscription"
tput cup 14 9; echo "9 - Chuc nang dang cap nhat"
echo "Ban chon chuc nang so may: ";read choice
case $choice in
	1) 
		echo "Ban da chon chuc nang so 1 (Kiem tra Hostname cua may hien tai)"
		echo "--------------------------------------------------------------"
		hostnamectl status
		echo "--------------------------------------------------------------"
		;;
	2)
	        echo "Ban da chon chuc nang so 2 (Thay doi ten Hostname)"
		echo "-------------------------------------------------------------"
		echo "Hay nhap ten Hostname moi: "
		read hn
		hostnamectl set-hostname "$hn"
		echo "---------------------Hostname da doi thanh cong-------------------------"
		hostnamectl status
		echo "-------------------------------END-------------------------------------"
		;;
	3)	echo "Ban da chon chuc nang so 3 (Kiem tra thong tin Card mang hien tai"
		echo "*** Luu y: Sau khi xem thong tin xong nhan Ctr+C de thoat ra"
		echo "-----------------------------------------------------------------"
		nmcli
		;;
	4)
		echo "Ban da chon chuc nang so 4(Doi IP tinh cua Card mang) "
		echo "*** Luu y: Nho xem thong tin Card mang truoc, de biet ten card mang "
		echo "*** Vidu: ens160,ens120 v.v.v"
		echo "-----------------------------------------------------"
		echo "Nhap ten Card mang muon doi IP:"
		read nw
		echo "Nhap IP muon doi (Vi du: 192.168.163.200/24): "
		read ipnew
		echo "Nhap GateWay moi (Vi du: 192.168.163.2) :"
		read gw
		echo "Nhap DNS 1 (Vi du: 192.168.163.2): "
		read dns1
		echo "Nhap DNS 2 (Vi du: 8.8.8.8, 1.1.1.1):"
		read dns2
		nmcli con mod "$nw" ipv4.method manual ipv4.address "$ipnew"
		nmcli con mod "$nw" ipv4.gateway "$gw"
		nmcli con mod "$nw" ipv4.dns "$dns1"
		nmcli con mod "$nw" ipv4.dns-search "$dns2"
		nmcli con down "$nw"
		nmcli con up "$nw"
		echo " "
		echo " "
		echo "-----------PING Google.com De kiem tra ket noi mang-----------------------"
		sleep 2
		ping google.com -c 4
		echo "-------------------------------------------------------------------------"
		echo " "
		echo " "
		echo "------------DA DOI IP IP THANH CONG, XEM LAI THONG TIN BEN DUOI------------"
		echo " "
		echo " "
		echo "===============>>>>>>>Vui long doi ti, dang tai lai thong tin Card mang............."
		sleep 3
		nmcli
		echo "---------------------------------------------------------------------------"
		;;
	5)	
		echo "Ban da chon chuc nang so 5 (Doi IP DHCP tu dong cua Card mang)"
		echo "*** Luu y: Nho dung chuc nang so 3, xem thong tin Card mang truoc de biet ten Card mang"
		echo "---------------------------------------------------------------------------------------"
		echo "Nhap ten Card mang muon doi DHCP tu dong (Vi du: ens160, ens122..): "
		read nw
		nmcli con mod "$nw" ipv4.gateway ""
		nmcli con mod "$nw" ipv4.dns ""
		nmcli con mod "$nw" ipv4.dns-search ""
		nmcli con mod "$nw" ipv4.method auto ipv4.address ""
		nmcli con down "$nw"
		nmcli con up "$nw"
		echo " "
		echo " "
		echo "-------PING GOOGLE.COM DE KIEM TRA KET NOI MANG-----------"
		sleep 2
		ping google.com -c 4
		echo "----------------------------------------------------------"
		echo " "
		echo " "
		echo "------------DA DOI IP DHCP THANH CONG, XEM LAI THONG TIN BEN DUOI---------"
		echo "=====>>>>>>>Vui long doi ti, dang tai lai thong tin Card mang.............."
		sleep 3
		nmcli
		echo "---------------------------------------------------------------------------"
		;;
	6)
		echo "Ban dang chon chuc nang so 6 ( Dang ky lai Subscription)"
		echo "-----------------------------------------------------------"
		subscription-manager remove --all
		subscription-manager unregister
		subscription-manager clean
		dnf clear all
		rm -rf /var/cache/yum/*
		subscription-manager register
		subscription-manager attach --auto
		subscription-manager list
		;;
	7)
		echo "Ban dang chon chuc nang so 7 (Truyen tap tin bang giao thuc SCP)"
		echo "---------------------------------------------------------------"
		echo "Nhap duong dan tap tin muon gui (Vi du gui file test.sh: /home/bac/test.sh): "
		read srdir
		echo "Nhap IP source (Vi du: 192.168.163.194):"
		read srip
		echo "Nhap user account cua may gui (Vi du: root, myuser1, bac):"
		read srusr
		echo "Nhap duong dan muon copy toi (Vi du copy file test.sh den thu muc Desktop cua may khac: /home/maykhac/):"
		read desdir
		echo "Nhap IP nhan (Vi du: 192.168.163.198):"
		read desip
		echo "Nhap user account cua may nhan (Vi du: root, myuser1...): "
		read desus
		scp -p "$srusr@$srip:$srdir" "$desus@$desip:$desdir"
		;;
	8)
		echo "Ban dang chon chuc nang so 8 (Huy dang ky Subscripttion)"
		echo "-----------------------------------------------------------"
		subscription-manager remove --all
		subscription-manager unregister
		subscription-manager clean
		dnf clear all
		rm -rf /var/cache/yum/*
	esac
