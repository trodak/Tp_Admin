#!/bin/bash
	function showUsers(){
	   cat /etc/passwd | cut -d ":" -f1 > users.txt
	   cat users.txt | while read ligne
	 do
	   ls /home/ | grep $ligne > users.txt
	 done
	 echo "la liste des utilisateurs est : "
	 while read ligne
	 do
	  echo "- $ligne"
	 done < users.txt
	}
	function archive(){
           read -p "entrer le chemin du périphérique externe : " path
	   user=$(cat /etc/group | grep sudo | cut -d ":" -f4)
	   sudo find /home/$user/* -ctime 2 > fichierstock.txt
	   mkdir archive
           cat fichierstock.txt | while read ligne
	 do
	   mv $ligne archive
	done
	  tar -cvs archive.tar archive/
	  gzip archive.tar	
	  cp archive.tar.gz $path
	}


question=1

while [ "$question" -eq 1 ];
do

 echo "Projet realiser par l'étudiant BAZOUWA TRODAK 13A962FS "  
 echo ""                                                                                       
 echo "*                                   WELCOME TO PROJECT SYS                                   *"
 echo "**********************************************************************************************"
 echo "*                                                                                            *"
 echo "* a) Informations des utilisateurs enregistré il y'a trois (03) jours                        *"
 echo "* b) Aquisition, Installation et Lancement de l'environnement XAMPP                          *"
 echo "* c) Archivage des éléments du repertoire personnel qui ont été modifier par l'utilisateur   *" 
 echo "*    sudoer il y'a deux jours dans le peripherique externe                                   *"
 echo "* d) Information sur l'utilisation du disque, de la mémoire, du processeur et du swap        *"
 echo "* q) Quitter (q) !                                                                          *"
 echo "*											    *"
 echo "*                                                                                            *"
 echo "*                                                    *"
 echo "***********************************************************************************************"


	echo -e "\n"
	echo -e "Veillez entrer une option: \c "
	read reponse

	case "$reponse" in 
		a) showUsers ;; 
		b)sudo /opt/lampp/lampp start 2> errtest ;
		  echo "Vous avez déjà installé XAMPP";
			if [ $? -ne 0 ]; then
                		wget https://www.apachefriends.org/xampp-files/7.0.18/xampp-osx-7.0.18-0-installer.dmg;
				sudo chmod 755 xampp-linux-*-installer.run;
				sudo ./xampp-linux-*-installer.run;
				sudo /opt/lampp/lampp start 2> errtest;
			fi ;;
		
		c) archive;;
		
		d)vmstat ;;
		
		q) exit ;;
  	esac
     echo -e " Cliquer sur enter pour continue.... \c"
     read input

done		
