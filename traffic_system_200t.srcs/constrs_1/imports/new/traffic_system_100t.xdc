#====================================================================
# 工程名称：traffic_system_100t
# 目标芯片：XC7A100T-2FGG484C
# Vivado Part：xc7a100tfgg484-2
#
# light_ew = {R,G,Y}，高电平点亮
# light_sn = {R,G,Y}，高电平点亮
# seg_data = {DP,G,F,E,D,C,B,A}，低电平点亮
# seg_sel  = 四位数码管位选，低电平有效
#====================================================================


#====================================================================
# 1. 100MHz系统时钟
#====================================================================

set_property PACKAGE_PIN W19 [get_ports clk_100m]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100m]

# 100MHz时钟周期为10ns
create_clock -period 10.000 -name clk_100m -waveform {0.000 5.000} [get_ports clk_100m]


#====================================================================
# 2. 东西方向三色交通灯
#
# light_ew[2] = R，红灯
# light_ew[1] = G，绿灯
# light_ew[0] = Y，黄灯
#====================================================================

set_property PACKAGE_PIN Y17 [get_ports {light_ew[2]}]
set_property PACKAGE_PIN M17 [get_ports {light_ew[1]}]
set_property PACKAGE_PIN E18 [get_ports {light_ew[0]}]


#====================================================================
# 3. 南北方向三色交通灯
#
# light_sn[2] = R，红灯
# light_sn[1] = G，绿灯
# light_sn[0] = Y，黄灯
#====================================================================

set_property PACKAGE_PIN N14 [get_ports {light_sn[2]}]
set_property PACKAGE_PIN E21 [get_ports {light_sn[1]}]
set_property PACKAGE_PIN E14 [get_ports {light_sn[0]}]


#====================================================================
# 4. 数码管段选信号
#
# seg_data[7] = DP
# seg_data[6] = G
# seg_data[5] = F
# seg_data[4] = E
# seg_data[3] = D
# seg_data[2] = C
# seg_data[1] = B
# seg_data[0] = A
#
# 段选信号低电平有效
#====================================================================

set_property PACKAGE_PIN C20 [get_ports {seg_data[7]}]
set_property PACKAGE_PIN L21 [get_ports {seg_data[6]}]
set_property PACKAGE_PIN K21 [get_ports {seg_data[5]}]
set_property PACKAGE_PIN M22 [get_ports {seg_data[4]}]
set_property PACKAGE_PIN K19 [get_ports {seg_data[3]}]
set_property PACKAGE_PIN N20 [get_ports {seg_data[2]}]
set_property PACKAGE_PIN K16 [get_ports {seg_data[1]}]
set_property PACKAGE_PIN F15 [get_ports {seg_data[0]}]


#====================================================================
# 5. 四位数码管位选信号
#
# seg_sel[0]：最右位
# seg_sel[1]：右起第二位
# seg_sel[2]：左起第二位
# seg_sel[3]：最左位
#
# 位选信号低电平有效
#====================================================================

set_property PACKAGE_PIN H13 [get_ports {seg_sel[0]}]
set_property PACKAGE_PIN D20 [get_ports {seg_sel[1]}]
set_property PACKAGE_PIN A14 [get_ports {seg_sel[2]}]
set_property PACKAGE_PIN B18 [get_ports {seg_sel[3]}]


#====================================================================
# 6. 所有交通灯输出的IO电平标准
#====================================================================

set_property IOSTANDARD LVCMOS33 [get_ports {light_ew[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_ew[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_ew[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_sn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_sn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_sn[0]}]


#====================================================================
# 7. 所有数码管输出的IO电平标准
#====================================================================

set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_sel[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_sel[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_sel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_sel[0]}]


#====================================================================
# 8. 输出驱动能力
#====================================================================

set_property DRIVE 8 [get_ports {light_ew[2]}]
set_property DRIVE 8 [get_ports {light_ew[1]}]
set_property DRIVE 8 [get_ports {light_ew[0]}]
set_property DRIVE 8 [get_ports {light_sn[2]}]
set_property DRIVE 8 [get_ports {light_sn[1]}]
set_property DRIVE 8 [get_ports {light_sn[0]}]
set_property DRIVE 8 [get_ports {seg_data[7]}]
set_property DRIVE 8 [get_ports {seg_data[6]}]
set_property DRIVE 8 [get_ports {seg_data[5]}]
set_property DRIVE 8 [get_ports {seg_data[4]}]
set_property DRIVE 8 [get_ports {seg_data[3]}]
set_property DRIVE 8 [get_ports {seg_data[2]}]
set_property DRIVE 8 [get_ports {seg_data[1]}]
set_property DRIVE 8 [get_ports {seg_data[0]}]
set_property DRIVE 8 [get_ports {seg_sel[3]}]
set_property DRIVE 8 [get_ports {seg_sel[2]}]
set_property DRIVE 8 [get_ports {seg_sel[1]}]
set_property DRIVE 8 [get_ports {seg_sel[0]}]


#====================================================================
# 9. 输出边沿速度
#====================================================================

set_property SLEW SLOW [get_ports {light_ew[2]}]
set_property SLEW SLOW [get_ports {light_ew[1]}]
set_property SLEW SLOW [get_ports {light_ew[0]}]
set_property SLEW SLOW [get_ports {light_sn[2]}]
set_property SLEW SLOW [get_ports {light_sn[1]}]
set_property SLEW SLOW [get_ports {light_sn[0]}]
set_property SLEW SLOW [get_ports {seg_data[7]}]
set_property SLEW SLOW [get_ports {seg_data[6]}]
set_property SLEW SLOW [get_ports {seg_data[5]}]
set_property SLEW SLOW [get_ports {seg_data[4]}]
set_property SLEW SLOW [get_ports {seg_data[3]}]
set_property SLEW SLOW [get_ports {seg_data[2]}]
set_property SLEW SLOW [get_ports {seg_data[1]}]
set_property SLEW SLOW [get_ports {seg_data[0]}]
set_property SLEW SLOW [get_ports {seg_sel[3]}]
set_property SLEW SLOW [get_ports {seg_sel[2]}]
set_property SLEW SLOW [get_ports {seg_sel[1]}]
set_property SLEW SLOW [get_ports {seg_sel[0]}]


#====================================================================
# 10. 100T-FGG484配置电压
#
# 100T-FGG484且CONFIG_VOLTAGE为3.3V时，
# CFGBVS必须设置为VCCO，否则会出现DRC CFGBVS-4。
#====================================================================

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]


