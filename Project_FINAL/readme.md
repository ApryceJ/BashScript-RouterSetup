+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Usage:
  Please run the main.sh to deploy a Centos 7 router with wifi or a mail server.

        eg. sudo sh main.sh

    All service dependent values are stored in service specific folders in the SERVICENAMEVAR files respective to the service. .cnf files are service config files that will be copied to the target VM directories to run the service.

    (eg. DHCP: dhcp/ dhcp_setup.sh, dhcpvar - variables for the script, dhcp.cnf - conf file for the service)

  This script must be run on the router VM first to setup routing and DNS for the internal VM network.

  The main.sh script must run at the root or above the other service folders and main.var should be at the same location.

Disclaimer:
  If changes to the values for network array for router or main server, there will be no error checking for those values.
  If connection is lost after running this script: too bad so sad.

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

          !!! Please confirm the following before running the script !!!

    Router VM Setup:
        Running OS: Centos 7
        1 wireless USB device attached to the VM
        At least 2 wired or Ethernet network adapters attached to the VM
            First Ethernet Adapter configured to bridge to the VLAN 2016
            Second adapter to an internal VM network

        An internet connection is assumed active on first run
        This script only handles 2 Ethernet adapters and 1 Wireless USB Adapter for network_setup at this moment.
        It is expandable to handle more wired and wireless adapters, however another entry for ip address values is needed in the networkvar file.

    Mail VM Setup:
        At least 1 wired or Ethernet network adapters attached to the same internal network as the SECOND adapter on the router.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                !! THIS SCRIPT WILL NOT RUN WITHOUT INTERNET !!

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Selecting services to run:
  In the main.var file you will find 2 arrays one for router setup and one for mail server setup.
  You can omit selections by commenting the array entries out.
  The different arrays will be used depending on the runformailsrv variable value

To decide between a router setup or a mail sever setup adjust the runformailsrv variable value in the main.var file.
  eg. 0 = router Setup
      1 = mail server setup

The script will always run the following for both VM's:

    Install base software packages with updates
    Turn off selinux and firewalld
    Changes the hostname respective to the runformailsrv switch stored in main.var file
    Updates entire system

Depending on the runformailsrv variable in the main.var file it will use different values for the following:

  Router services that will be installed:
    network with networkmanager
    quagga with zebra and ospf
    dhcpd
    unbound
    nsd
    hostapd
    iptables
    
Mail VM services:
    postfix
    dovecot
