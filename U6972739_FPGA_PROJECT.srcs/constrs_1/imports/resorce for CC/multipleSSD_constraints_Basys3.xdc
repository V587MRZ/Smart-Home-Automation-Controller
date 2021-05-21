
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports sysclk]
create_clock -period 10.00 [get_ports sysclk]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports remote_control]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports collision_sensor]
set_property -dict {PACKAGE_PIN W3 IOSTANDARD LVCMOS33} [get_ports Motor]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports reset]

set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {index[0]}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {index[1]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {index[2]}]
set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports {LEDs[9]}]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {LEDs[8]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {LEDs[7]}]
set_property -dict {PACKAGE_PIN  U14 IOSTANDARD LVCMOS33} [get_ports {LEDs[6]}]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {LEDs[5]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {LEDs[4]}]
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {LEDs[3]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {LEDs[2]}]
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {LEDs[1]}]
set_property -dict {PACKAGE_PIN  U16 IOSTANDARD LVCMOS33} [get_ports {LEDs[0]}]
set_property -dict {PACKAGE_PIN  U17 IOSTANDARD LVCMOS33} [get_ports switch]

set_property PACKAGE_PIN W19 [get_ports enter]
set_property IOSTANDARD LVCMOS33 [get_ports enter]

set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {ssdAnode[0]}]
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {ssdAnode[1]}]
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {ssdAnode[2]}]
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {ssdAnode[3]}]
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {ssdCathode[6]}]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {ssdCathode[5]}]
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {ssdCathode[4]}]
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {ssdCathode[3]}]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {ssdCathode[2]}]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {ssdCathode[1]}]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {ssdCathode[0]}]

set_property PACKAGE_PIN V17 [get_ports {one}]
	set_property IOSTANDARD LVCMOS33 [get_ports {one}]
set_property PACKAGE_PIN V16 [get_ports {two}]
	set_property IOSTANDARD LVCMOS33 [get_ports {two}]
set_property PACKAGE_PIN W16 [get_ports {four}]
	set_property IOSTANDARD LVCMOS33 [get_ports {four}]
	
#led
set_property PACKAGE_PIN U3 [get_ports LED_out]
	set_property IOSTANDARD LVCMOS33 [get_ports LED_out]

set_property PACKAGE_PIN P3 [get_ports LED_bath]
	set_property IOSTANDARD LVCMOS33 [get_ports LED_bath]

	

#Switch
set_property PACKAGE_PIN R3 [get_ports {dark}]
	set_property IOSTANDARD LVCMOS33 [get_ports {dark}]
set_property PACKAGE_PIN U1 [get_ports {entering}]
	set_property IOSTANDARD LVCMOS33 [get_ports {entering}]
set_property PACKAGE_PIN W2 [get_ports {motion}]
	set_property IOSTANDARD LVCMOS33 [get_ports {motion}]
set_property PACKAGE_PIN T1 [get_ports {master_off}]
	set_property IOSTANDARD LVCMOS33 [get_ports {master_off}]
set_property PACKAGE_PIN R2 [get_ports {master_on}]
	set_property IOSTANDARD LVCMOS33 [get_ports {master_on}]

