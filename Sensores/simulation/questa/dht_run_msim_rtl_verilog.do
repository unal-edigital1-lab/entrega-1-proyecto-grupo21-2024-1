transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/crist/OneDrive/Escritorio/Sensor\ de\ temperatura {C:/Users/crist/OneDrive/Escritorio/Sensor de temperatura/display_controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/crist/OneDrive/Escritorio/Sensor\ de\ temperatura {C:/Users/crist/OneDrive/Escritorio/Sensor de temperatura/dht.v}
vlog -vlog01compat -work work +incdir+C:/Users/crist/OneDrive/Escritorio/Sensor\ de\ temperatura {C:/Users/crist/OneDrive/Escritorio/Sensor de temperatura/bcd_to_7seg.v}

vlog -vlog01compat -work work +incdir+C:/Users/crist/OneDrive/Escritorio/Sensor\ de\ temperatura {C:/Users/crist/OneDrive/Escritorio/Sensor de temperatura/dht_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  dht_TB

add wave *
view structure
view signals
run -all
