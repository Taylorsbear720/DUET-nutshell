
################################################################
# This is a generated script based on design: nutshell
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source nutshell_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# NutShell

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu19eg-ffvc1760-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name nutshell

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_protocol_converter:2.1\
xilinx.com:ip:system_ila:1.1\
xilinx.com:ip:util_vector_logic:2.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
NutShell\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set AXI_DMA [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 AXI_DMA ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.CLK_DOMAIN {/clk_wiz_0_clk_out1} \
   CONFIG.DATA_WIDTH {64} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {1} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {16} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0.0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $AXI_DMA

  set AXI_MEM [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 AXI_MEM ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.CLK_DOMAIN {/clk_wiz_0_clk_out1} \
   CONFIG.DATA_WIDTH {64} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.PHASE {0.0} \
   CONFIG.PROTOCOL {AXI4} \
   ] $AXI_MEM

  set AXI_MMIO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 AXI_MMIO ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.CLK_DOMAIN {/clk_wiz_0_clk_out1} \
   CONFIG.DATA_WIDTH {64} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.PHASE {0.0} \
   CONFIG.PROTOCOL {AXI4} \
   ] $AXI_MMIO


  # Create ports
  set button_corerstn [ create_bd_port -dir I button_corerstn ]
  set coreclk [ create_bd_port -dir I -type clk -freq_hz 100000000 coreclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_RESET {corerstn} \
 ] $coreclk
  set corerstn [ create_bd_port -dir I -type data corerstn ]
  set ilaclk [ create_bd_port -dir I -type clk -freq_hz 100000000 ilaclk ]
  set intrs [ create_bd_port -dir I -from 4 -to 0 intrs ]
  set io_ila_InstrCnt_0 [ create_bd_port -dir O -from 63 -to 0 io_ila_InstrCnt_0 ]
  set io_ila_WBUInstr [ create_bd_port -dir O -from 63 -to 0 io_ila_WBUInstr ]
  set io_ila_WBUpc_0 [ create_bd_port -dir O -from 38 -to 0 io_ila_WBUpc_0 ]
  set io_ila_WBUrfData_0 [ create_bd_port -dir O -from 63 -to 0 io_ila_WBUrfData_0 ]
  set io_ila_WBUrfDest_0 [ create_bd_port -dir O -from 4 -to 0 io_ila_WBUrfDest_0 ]
  set io_ila_WBUrfWen_0 [ create_bd_port -dir O io_ila_WBUrfWen_0 ]
  set io_ila_WBUvalid_0 [ create_bd_port -dir O io_ila_WBUvalid_0 ]
  set io_ila_cause [ create_bd_port -dir O -from 31 -to 0 io_ila_cause ]
  set io_ila_code [ create_bd_port -dir O -from 7 -to 0 io_ila_code ]
  set io_ila_cycleCnt [ create_bd_port -dir O -from 63 -to 0 io_ila_cycleCnt ]
  set io_ila_exceptionInst [ create_bd_port -dir O -from 31 -to 0 io_ila_exceptionInst ]
  set io_ila_exceptionPC [ create_bd_port -dir O -from 63 -to 0 io_ila_exceptionPC ]
  set io_ila_intrNO [ create_bd_port -dir O -from 31 -to 0 io_ila_intrNO ]
  set io_ila_isMMIO_0 [ create_bd_port -dir O io_ila_isMMIO_0 ]
  set io_ila_isRVC [ create_bd_port -dir O io_ila_isRVC ]
  set io_ila_mcause [ create_bd_port -dir O -from 63 -to 0 io_ila_mcause ]
  set io_ila_medeleg [ create_bd_port -dir O -from 63 -to 0 io_ila_medeleg ]
  set io_ila_mepc [ create_bd_port -dir O -from 63 -to 0 io_ila_mepc ]
  set io_ila_mideleg [ create_bd_port -dir O -from 63 -to 0 io_ila_mideleg ]
  set io_ila_mie [ create_bd_port -dir O -from 63 -to 0 io_ila_mie ]
  set io_ila_mipReg [ create_bd_port -dir O -from 63 -to 0 io_ila_mipReg ]
  set io_ila_mscratch [ create_bd_port -dir O -from 63 -to 0 io_ila_mscratch ]
  set io_ila_mstatus [ create_bd_port -dir O -from 63 -to 0 io_ila_mstatus ]
  set io_ila_mtval [ create_bd_port -dir O -from 63 -to 0 io_ila_mtval ]
  set io_ila_mtvec [ create_bd_port -dir O -from 63 -to 0 io_ila_mtvec ]
  set io_ila_nutcoretrap [ create_bd_port -dir O io_ila_nutcoretrap ]
  set io_ila_pc [ create_bd_port -dir O -from 63 -to 0 io_ila_pc ]
  set io_ila_priviledgeMode [ create_bd_port -dir O -from 7 -to 0 io_ila_priviledgeMode ]
  set io_ila_rfwen [ create_bd_port -dir O io_ila_rfwen ]
  set io_ila_satp [ create_bd_port -dir O -from 63 -to 0 io_ila_satp ]
  set io_ila_scause [ create_bd_port -dir O -from 63 -to 0 io_ila_scause ]
  set io_ila_sepc [ create_bd_port -dir O -from 63 -to 0 io_ila_sepc ]
  set io_ila_sscratch [ create_bd_port -dir O -from 63 -to 0 io_ila_sscratch ]
  set io_ila_sstatus [ create_bd_port -dir O -from 63 -to 0 io_ila_sstatus ]
  set io_ila_stval [ create_bd_port -dir O -from 63 -to 0 io_ila_stval ]
  set io_ila_stvec [ create_bd_port -dir O -from 63 -to 0 io_ila_stvec ]
  set led_resetn [ create_bd_port -dir O -from 0 -to 0 led_resetn ]
  set reg_gpr_6_0 [ create_bd_port -dir O -from 63 -to 0 reg_gpr_6_0 ]
  set uncoreclk [ create_bd_port -dir I -type clk -freq_hz 100000000 uncoreclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_RESET {uncorerstn} \
   CONFIG.CLK_DOMAIN {/clk_wiz_0_clk_out1} \
   CONFIG.PHASE {0.0} \
 ] $uncoreclk
  set uncorerstn [ create_bd_port -dir I -type rst uncorerstn ]

  # Create instance: NutShell_0, and set properties
  set block_name NutShell
  set block_cell_name NutShell_0
  if { [catch {set NutShell_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $NutShell_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] [get_bd_pins /NutShell_0/reset]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
 ] $axi_interconnect_1

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_2 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
 ] $axi_interconnect_2

  # Create instance: axi_protocol_convert_0, and set properties
  set axi_protocol_convert_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_0 ]
  set_property -dict [ list \
   CONFIG.MI_PROTOCOL {AXI4LITE} \
   CONFIG.SI_PROTOCOL {AXI4} \
 ] $axi_protocol_convert_0

  # Create instance: axi_protocol_convert_1, and set properties
  set axi_protocol_convert_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_1 ]

  # Create instance: system_ila_1, and set properties
  set system_ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_1 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {1} \
   CONFIG.C_MON_TYPE {NATIVE} \
   CONFIG.C_NUM_OF_PROBES {36} \
 ] $system_ila_1

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_1

  # Create interface connections
  connect_bd_intf_net -intf_net M_AXI_DMA_1 [get_bd_intf_ports AXI_DMA] [get_bd_intf_pins axi_protocol_convert_0/S_AXI]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins axi_protocol_convert_1/M_AXI]
  connect_bd_intf_net -intf_net axi_clock_converter_0_M_AXI [get_bd_intf_ports AXI_MEM] [get_bd_intf_pins axi_interconnect_2/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins NutShell_0/io_frontend] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_ports AXI_MMIO] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net axi_protocol_convert_0_M_AXI [get_bd_intf_pins axi_protocol_convert_0/M_AXI] [get_bd_intf_pins axi_protocol_convert_1/S_AXI]

  # Create port connections
  connect_bd_net -net NutShell_0_io_ila_InstrCnt [get_bd_ports io_ila_InstrCnt_0] [get_bd_pins system_ila_1/probe5]
  connect_bd_net -net NutShell_0_io_ila_WBUInstr [get_bd_ports io_ila_WBUInstr] [get_bd_pins system_ila_1/probe7]
  connect_bd_net -net NutShell_0_io_ila_WBUpc [get_bd_ports io_ila_WBUpc_0] [get_bd_pins system_ila_1/probe0]
  connect_bd_net -net NutShell_0_io_ila_WBUrfData [get_bd_ports io_ila_WBUrfData_0] [get_bd_pins system_ila_1/probe4]
  connect_bd_net -net NutShell_0_io_ila_WBUrfDest [get_bd_ports io_ila_WBUrfDest_0] [get_bd_pins system_ila_1/probe3]
  connect_bd_net -net NutShell_0_io_ila_WBUrfWen [get_bd_ports io_ila_WBUrfWen_0] [get_bd_pins system_ila_1/probe2]
  connect_bd_net -net NutShell_0_io_ila_WBUvalid [get_bd_ports io_ila_WBUvalid_0] [get_bd_pins system_ila_1/probe1]
  connect_bd_net -net NutShell_0_io_ila_cause [get_bd_ports io_ila_cause] [get_bd_pins system_ila_1/probe29]
  connect_bd_net -net NutShell_0_io_ila_code [get_bd_ports io_ila_code] [get_bd_pins system_ila_1/probe33]
  connect_bd_net -net NutShell_0_io_ila_cycleCnt [get_bd_ports io_ila_cycleCnt] [get_bd_pins system_ila_1/probe35]
  connect_bd_net -net NutShell_0_io_ila_exceptionInst [get_bd_ports io_ila_exceptionInst] [get_bd_pins system_ila_1/probe31]
  connect_bd_net -net NutShell_0_io_ila_exceptionPC [get_bd_ports io_ila_exceptionPC] [get_bd_pins system_ila_1/probe30]
  connect_bd_net -net NutShell_0_io_ila_intrNO [get_bd_ports io_ila_intrNO] [get_bd_pins system_ila_1/probe28]
  connect_bd_net -net NutShell_0_io_ila_isMMIO [get_bd_ports io_ila_isMMIO_0] [get_bd_pins system_ila_1/probe6]
  connect_bd_net -net NutShell_0_io_ila_isRVC [get_bd_ports io_ila_isRVC] [get_bd_pins system_ila_1/probe9]
  connect_bd_net -net NutShell_0_io_ila_mcause [get_bd_ports io_ila_mcause] [get_bd_pins system_ila_1/probe19]
  connect_bd_net -net NutShell_0_io_ila_medeleg [get_bd_ports io_ila_medeleg] [get_bd_pins system_ila_1/probe27]
  connect_bd_net -net NutShell_0_io_ila_mepc [get_bd_ports io_ila_mepc] [get_bd_pins system_ila_1/probe13]
  connect_bd_net -net NutShell_0_io_ila_mideleg [get_bd_ports io_ila_mideleg] [get_bd_pins system_ila_1/probe26]
  connect_bd_net -net NutShell_0_io_ila_mie [get_bd_ports io_ila_mie] [get_bd_pins system_ila_1/probe23]
  connect_bd_net -net NutShell_0_io_ila_mipReg [get_bd_ports io_ila_mipReg] [get_bd_pins system_ila_1/probe22]
  connect_bd_net -net NutShell_0_io_ila_mscratch [get_bd_ports io_ila_mscratch] [get_bd_pins system_ila_1/probe24]
  connect_bd_net -net NutShell_0_io_ila_mstatus [get_bd_ports io_ila_mstatus] [get_bd_pins system_ila_1/probe11]
  connect_bd_net -net NutShell_0_io_ila_mtval [get_bd_ports io_ila_mtval] [get_bd_pins system_ila_1/probe15]
  connect_bd_net -net NutShell_0_io_ila_mtvec [get_bd_ports io_ila_mtvec] [get_bd_pins system_ila_1/probe17]
  connect_bd_net -net NutShell_0_io_ila_nutcoretrap [get_bd_ports io_ila_nutcoretrap] [get_bd_pins system_ila_1/probe32]
  connect_bd_net -net NutShell_0_io_ila_pc [get_bd_ports io_ila_pc] [get_bd_pins system_ila_1/probe34]
  connect_bd_net -net NutShell_0_io_ila_priviledgeMode [get_bd_ports io_ila_priviledgeMode] [get_bd_pins system_ila_1/probe10]
  connect_bd_net -net NutShell_0_io_ila_rfwen [get_bd_ports io_ila_rfwen] [get_bd_pins system_ila_1/probe8]
  connect_bd_net -net NutShell_0_io_ila_satp [get_bd_ports io_ila_satp] [get_bd_pins system_ila_1/probe21]
  connect_bd_net -net NutShell_0_io_ila_scause [get_bd_ports io_ila_scause] [get_bd_pins system_ila_1/probe20]
  connect_bd_net -net NutShell_0_io_ila_sepc [get_bd_ports io_ila_sepc] [get_bd_pins system_ila_1/probe14]
  connect_bd_net -net NutShell_0_io_ila_sscratch [get_bd_ports io_ila_sscratch] [get_bd_pins system_ila_1/probe25]
  connect_bd_net -net NutShell_0_io_ila_sstatus [get_bd_ports io_ila_sstatus] [get_bd_pins system_ila_1/probe12]
  connect_bd_net -net NutShell_0_io_ila_stval [get_bd_ports io_ila_stval] [get_bd_pins system_ila_1/probe16]
  connect_bd_net -net NutShell_0_io_ila_stvec [get_bd_ports io_ila_stvec] [get_bd_pins system_ila_1/probe18]
  connect_bd_net -net button_corerstn_1 [get_bd_ports button_corerstn] [get_bd_pins util_vector_logic_1/Op2]
  connect_bd_net -net c_shift_ram_0_Q [get_bd_ports led_resetn] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN] [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net coreclk_1 [get_bd_ports coreclk] [get_bd_pins NutShell_0/clock] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK]
  connect_bd_net -net corerstn_1 [get_bd_ports corerstn] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net ilaclk_1 [get_bd_ports ilaclk] [get_bd_pins system_ila_1/clk]
  connect_bd_net -net intrs_1 [get_bd_ports intrs] [get_bd_pins NutShell_0/io_meip]
  connect_bd_net -net uncoreclk_1 [get_bd_ports uncoreclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axi_protocol_convert_0/aclk] [get_bd_pins axi_protocol_convert_1/aclk]
  connect_bd_net -net uncorerstn_2 [get_bd_ports uncorerstn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axi_protocol_convert_0/aresetn] [get_bd_pins axi_protocol_convert_1/aresetn]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins NutShell_0/reset] [get_bd_pins util_vector_logic_0/Res]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces AXI_DMA] [get_bd_addr_segs NutShell_0/io_frontend/reg0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_gid_msg -ssname BD::TCL -id 2053 -severity "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

