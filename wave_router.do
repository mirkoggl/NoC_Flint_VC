onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_router/clk
add wave -noupdate /tb_router/reset
add wave -noupdate -radix hexadecimal -childformat {{/tb_router/Data_In(0) -radix hexadecimal} {/tb_router/Data_In(1) -radix hexadecimal} {/tb_router/Data_In(2) -radix hexadecimal} {/tb_router/Data_In(3) -radix hexadecimal} {/tb_router/Data_In(4) -radix hexadecimal}} -subitemconfig {/tb_router/Data_In(0) {-height 15 -radix hexadecimal} /tb_router/Data_In(1) {-height 15 -radix hexadecimal} /tb_router/Data_In(2) {-height 15 -radix hexadecimal} /tb_router/Data_In(3) {-height 15 -radix hexadecimal} /tb_router/Data_In(4) {-height 15 -radix hexadecimal}} /tb_router/Data_In
add wave -noupdate -divider {Input 0}
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Valid_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Shft_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Ready_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Empty_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 1}
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Valid_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Shft_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Ready_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Empty_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 2}
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Valid_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Shft_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Ready_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Empty_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 3}
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Valid_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Shft_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Ready_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Empty_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 4}
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Valid_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Shft_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Ready_Out
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Empty_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/fifo_memory
add wave -noupdate -divider CU
add wave -noupdate -radix hexadecimal /tb_router/uut/CU_inst/Data_II
add wave -noupdate /tb_router/uut/CU_inst/Empty_II
add wave -noupdate /tb_router/uut/CU_inst/Full_OI
add wave -noupdate /tb_router/uut/CU_inst/Shft_II
add wave -noupdate /tb_router/uut/CU_inst/Wr_En_OI
add wave -noupdate -radix unsigned /tb_router/uut/CU_inst/Cross_Sel
add wave -noupdate /tb_router/uut/CU_inst/current_s
add wave -noupdate -radix hexadecimal /tb_router/uut/CU_inst/xy_data_in
add wave -noupdate -radix unsigned /tb_router/uut/CU_inst/xy_chan_in
add wave -noupdate /tb_router/uut/CU_inst/xy_chan_out
add wave -noupdate -divider Crossbar
add wave -noupdate -radix unsigned /tb_router/uut/Crossbar_inst/sel
add wave -noupdate -radix hexadecimal /tb_router/uut/Crossbar_inst/Data_In
add wave -noupdate -radix hexadecimal -childformat {{/tb_router/uut/Crossbar_inst/Data_Out(0) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(1) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(2) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(3) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(4) -radix unsigned}} -subitemconfig {/tb_router/uut/Crossbar_inst/Data_Out(0) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(1) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(2) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(3) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(4) {-height 15 -radix unsigned}} /tb_router/uut/Crossbar_inst/Data_Out
add wave -noupdate -divider {Output 0}
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/Ready_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/WrEn_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/Full_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/Valid_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 1}
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/Ready_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/WrEn_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/Full_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/Valid_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 2}
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/Ready_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/WrEn_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/Full_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/Valid_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 3}
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/Ready_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/WrEn_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/Full_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/Valid_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 4}
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/Data_In
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/Ready_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/WrEn_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/Full_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/Valid_Out
add wave -noupdate -radix hexadecimal /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/fifo_memory
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {56449 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {245425 ps}
